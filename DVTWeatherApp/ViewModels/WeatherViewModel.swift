import Foundation
import CoreLocation
import Combine
import SwiftUI

class WeatherViewModel: ObservableObject {
    
    
    @Published var location = ""
    @Published var isLoading: Bool = false
    @Published var weather: ResponseData = defaultResponseData
    
    @AppStorage("location") var storageLocation: String = ""
    
    var appError: AppError? = nil
    private let weatherService = WeatherService()
    private var locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.fetchWeather(location: location)
            }
            .store(in: &cancellables)
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

extension WeatherViewModel {
    
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
