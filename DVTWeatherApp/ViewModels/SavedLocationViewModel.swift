//
//  SavedLocationViewModel.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/22.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

class SavedLocationViewModel: ObservableObject {
    @Published var location = ""
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false
    @Published var weather: ResponseData = defaultResponseData
    @Published var appError: AppError? = nil
    
    let savedLocation: CLLocation
    var weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()
    
    init(savedLocation: CLLocation) {
        self.savedLocation = savedLocation
        fetchWeather(isInitialLoad: true)
    }
    
    func fetchWeather(isInitialLoad: Bool = false) {
        if isInitialLoad {
            isLoading = true
        } else {
            isRefreshing = true
        }
        
        weatherService.fetchWeatherData(for: savedLocation) { [weak self] result in
            DispatchQueue.main.async {
                if isInitialLoad {
                    self?.isLoading = false
                } else {
                    self?.isRefreshing = false
                }
                
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

extension SavedLocationViewModel {
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
        case "Rain":
            return Image("forest_rainy")
        case "Clear":
            return Image("forest_sunny")
        case "Clouds":
            return Image("forest_cloudy")
        default:
            return nil
        }
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
        return Formatters().weeklyDay.string(from: Date(timeIntervalSince1970: weather.list[0].dt))
    }
    
    var overview: String {
        return weather.list[0].weather[0].description.capitalized
    }
    
    var temperature: String {
        return "\(Formatters.numberFormatter.string(for: Formatters().convert(weather.list[0].main.temp)) ?? "0")°"
    }
    
    var minTemperature: String {
        return "\(Formatters.numberFormatter.string(for: Formatters().convert(weather.list[0].main.tempMin)) ?? "0")°"
    }
    
    var maxTemperature: String {
        return "\(Formatters.numberFormatter.string(for: Formatters().convert(weather.list[0].main.tempMax)) ?? "0")°"
    }
    
    var high: String {
        return "H: \(Formatters.numberFormatter.string(for: Formatters().convert(weather.list[0].main.tempMax)) ?? "0")°"
    }
    
    var low: String {
        return "L: \(Formatters.numberFormatter.string(for: Formatters().convert(weather.list[0].main.tempMin)) ?? "0")°"
    }
    
    var feels: String {
        return "\(Formatters.numberFormatter.string(for: Formatters().convert(weather.list[0].main.feelsLike)) ?? "0")°"
    }
    
    var pop: String {
        return "\(Formatters.numberFormatter2.string(for: weather.list[0].pop.roundDouble()) ?? "0%")"
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
        return "\(Formatters.numberFormatter.string(for: weather.list[0].wind.speed) ?? "0")m/s"
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
}
