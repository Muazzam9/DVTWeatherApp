//
//  Formatters.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/20.
//

import Foundation
class Formatters: ObservableObject {
    
    let weeklyDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    func formattedTime(from string: String,  timeZoneOffset: Double) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YY/MM/dd"
        
        if let date = inputFormatter.date(from: string) {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
            return weeklyDay.string(from: date)
        }
        return nil
    }
    
    func formatTime(unixTime: Date, timeZoneOffset: Double) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE d, MMM"
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
        return formatter.string(from: date)
    }
    
    func formatedTime(time: Date, timeZoneOffset: Double) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E, HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
        return formatter.string(from: date)
    }
    
    func formatTime(unixTime: Double, timeZoneOffset: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
        return formatter.string(from: date)
    }
    
    func formattedHourlyTime(time: Double, timeZoneOffset: Double) -> String {
        let date = Date(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
        return formatter.string(from: date)
    }
    
    static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        return celsius
    }
}
