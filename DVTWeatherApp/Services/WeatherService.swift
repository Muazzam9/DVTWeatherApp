//
//  WeatherService.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/16.
//

import Foundation
import CoreLocation

class WeatherService {
    private let apiKey = "3d919e7f3e82c534fc32fc9e77cdd22f"

    func getCurrentWeather(location: CLLocation, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        print(">>> Calling getCurrentWeather")
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(">>> Error fetching weather: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
                print(">>> WeatherResponse: \(weatherResponse)")
            } catch {
                print(">>> Error decoding weather response: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }

    func get5DayForecast(location: CLLocation, completion: @escaping (Result<ForcastResponse, Error>) -> Void) {
        print(">>> Calling get5DayForecast")
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(">>> Error fetching forecast: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            if let jsonString = String(data: data, encoding: .utf8) {
                                print(">>> Data: \(jsonString)")
                            } else {
                                print(">>> Data could not be converted to UTF-8 string")
                            }
            do {
                let forecastResponse = try JSONDecoder().decode(ForcastResponse.self, from: data)
                completion(.success(forecastResponse))
                print(">>> ForecastResponse: \(forecastResponse)")
            } catch {
                print(">>> Error decoding forecast response: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
