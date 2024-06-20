//
//  LoggingConfiguration.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/20.
//

import UIKit
import Willow

var log: Logger = .disabled

struct LoggingConfiguration {
    // MARK: - Modifiers
    private struct PrefixModifier: LogModifier {
        let prefix: String
        let name: String

        init(prefix: String, name: String) {
            self.prefix = prefix
            self.name = name
        }

        func modifyMessage(_ message: String, with logLevel: LogLevel) -> String {
            switch logLevel {
            case .debug: return "◽️ => \(message)"
            case .info:  return "🔷 => \(message)"
            case .warn:  return "🔶 => \(message)"
            case .error: return "❌ => \(message)"
            default:     return "\(prefix) => \(message)"
            }
        }
    }

    // MARK: - Configure
    static func configure() {
        #if DEBUG
        // A debug build of the application would probably log at a higher level than a release version.
        // Also, synchronous logging can be beneficial in debug mode so that log statements emit as you step through the code.
        let appLogLevels: LogLevel = [.all]
        let executionMethod: Logger.ExecutionMethod = .synchronous(lock: NSRecursiveLock())
        #else
        // A release build probably logs only important data, omitting verbose debug information.
        // Also, asynchronous logging can be desirable to not hold up the current thread for each log statement.
        // Note that the execution method encapsulates the dispatch queue allowing for all logger instances using the same
        // execution method to share the same queue and be correctly synchronized.
        let appLogLevels: LogLevel = [.event, .warn, .error]
        let executionMethod: Logger.ExecutionMethod = .asynchronous(
            queue: DispatchQueue(label: "DVT.logger", qos: .utility)
        )
        #endif

        log = createLogger(
            prefix: "Log",
            name: "DVTWeatherApp",
            logLevels: appLogLevels,
            executionMethod: executionMethod
        )
    }

    private static func createLogger(
        prefix: String,
        name: String,
        logLevels: LogLevel,
        executionMethod: Logger.ExecutionMethod)
        -> Logger
    {
        let prefixModifier = PrefixModifier(prefix: prefix, name: name)
        let timestampModifier = TimestampModifier()
        let writers: [LogWriter] = [ConsoleWriter(modifiers: [prefixModifier, timestampModifier])]

        return Logger(logLevels: logLevels, writers: writers, executionMethod: executionMethod)
    }
}

extension Logger {
    public func verboseMessage(_ message: @autoclosure @escaping () -> String, file: StaticString = #file, line: UInt = #line) {
        let filepath = file.description
        let filename = filepath.components(separatedBy: "/").last
        let verboseMessage: () -> String = { return "\(filename ?? "_") (\(line)): \(message())" }
        logMessage(verboseMessage, with: .debug)
    }

    public func verboseMessage(_ message: @escaping () -> String, file: StaticString = #file, line: UInt = #line) {
        let filepath = file.description
        let filename = filepath.components(separatedBy: "/").last
        let verboseMessage: () -> String = { return "\(filename ?? "_") (\(line)): \(message())" }
        logMessage(verboseMessage, with: .debug)
    }

}
