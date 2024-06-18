//
//  WeatherViewModel.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/16.
//

import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: WeatherResponse?
    @Published var forecast: [WeatherData] = []
    @Published var errorMessage: String?

    private let weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()

    private var locationManager = LocationManager()

    init() {
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                print(">>> Location received in ViewModel: \(location)")
                self?.fetchWeather(for: location)
                self?.fetchForecast(for: location)
            }
            .store(in: &cancellables)
    }

    func fetchWeather(for location: CLLocation) {
        print(">>> Fetching weather for location: \(location)")
        weatherService.getCurrentWeather(location: location) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    print(">>> Weather response received: \(weatherResponse)")
                    self?.currentWeather = weatherResponse
                case .failure(let error):
                    print(">>> Weather fetch error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchForecast(for location: CLLocation) {
        print(">>> Fetching forecast for location: \(location)")
        weatherService.get5DayForecast(location: location) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let forecastResponse):
                    print(">>> Forecast response received: \(forecastResponse)")
                    self?.forecast = forecastResponse.list
                case .failure(let error):
                    print(">>> Forecast fetch error: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
