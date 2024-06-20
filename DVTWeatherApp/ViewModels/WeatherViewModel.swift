import Foundation
import CoreLocation
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
    var appError: AppError? = nil
    
    @Published var weather: ResponseData = ObjectFactory.responseData
    @Published var isLoading: Bool = false
    @AppStorage("location") var storageLocation: String = ""
    @Published var location = ""
    private var cancellables = Set<AnyCancellable>()
    private var locationManager = LocationManager()
    private let weatherService = WeatherService()
    
    init() {
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.fetchWeather(location: location)
            }
            .store(in: &cancellables)
    }
    
    var backgroundColor: Color {
            switch weather.list.first?.weather.first?.main ?? "" {
            case "Rain":
                return .rainy
            case "Clear":
                return .sunny
            case "Clouds":
                return .cloudy
            default:
                return Color.gray.opacity(0.1)
            }
        }

        var backgroundImage: Image? {
            switch weather.list.first?.weather.first?.main ?? "" {
            case "Clear":
                return Image("forest_sunny")
            default:
                return nil
            }
        }
    
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
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        }
        return nil
    }
    
    func formatTime(unixTime: Date, timeZoneOffset: Double) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
        return formatter.string(from: unixTime)
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
    
    func weatherIcon(for condition: String) -> Image {
        switch condition {
        case "Clear":
            return Image(systemName: "sun.max.fill")
        case "Clouds":
            return Image(systemName: "cloud.fill")
        case "Rain":
            return Image(systemName: "cloud.rain.fill")
        case "Snow":
            return Image(systemName: "cloud.snow.fill")
        default:
            return Image(systemName: "questionmark")
        }
    }
    
    var name: String {
        return weather.city.name
    }
    
    var day: String {
        return weeklyDay.string(from: Date(timeIntervalSince1970: weather.list[0].dt))
    }
    
    var overview: String {
        return weather.list[0].weather[0].description.capitalized
    }
    
    var temperature: String {
        return "\(Self.numberFormatter.string(for: convert(weather.list[0].main.temp)) ?? "0")°"
    }
    
    var high: String {
        return "H: \(Self.numberFormatter.string(for: convert(weather.list[0].main.tempMax)) ?? "0")°"
    }
    
    var low: String {
        return "L: \(Self.numberFormatter.string(for: convert(weather.list[0].main.tempMin)) ?? "0")°"
    }
    
    var feels: String {
        return "\(Self.numberFormatter.string(for: convert(weather.list[0].main.feelsLike)) ?? "0")°"
    }
    
    var pop: String {
        return "\(Self.numberFormatter2.string(for: weather.list[0].pop.roundDouble()) ?? "0%")"
    }
    
    var main: String {
        return "\(weather[0].weather[0].main)"
    }
    
    var clouds: String {
        return "\(weather.list[0].clouds)%"
    }
    
    var humidity: String {
        return "\(weather.list[0].main.humidity.roundDouble())%"
    }
    
    var wind: String {
        return "\(Self.numberFormatter.string(for: weather.list[0].wind.speed) ?? "0")m/s"
    }
    
    public struct DailyForecast {
        let day: String
        let maxTemp: Double
        let minTemp: Double
        let main: String
    }
    
    public var dailyForecasts: [DailyForecast] {
        let groupedData = Dictionary(grouping: weather.list) { (element) -> Substring in
            return element.localTime.prefix(10)
        }
        
        return groupedData.compactMap { (key, values) in
            guard let maxTemp = values.max(by: { $0.main.tempMax < $1.main.tempMax }),
                  let minTemp = values.min(by: { $0.main.tempMin < $1.main.tempMin }) else {
                return nil
            }
            return DailyForecast(day: String(key),
                                 maxTemp: maxTemp.main.tempMax,
                                 minTemp: minTemp.main.tempMin,
                                 main: maxTemp.weather[0].main)
        }
    }
    
    func fetchWeather(location: CLLocation) {
        isLoading = true
        weatherService.fetchWeatherData(for: location) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let weatherData):
                    self?.weather = weatherData
                case .failure(let error):
                    self?.appError = AppError(errorString: error.localizedDescription)
                }
            }
        }
    }
}
