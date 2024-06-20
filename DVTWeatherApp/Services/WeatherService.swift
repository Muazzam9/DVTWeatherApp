//
//  WeatherService.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/16.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

class WeatherService {
    private let apiKey = "3d919e7f3e82c534fc32fc9e77cdd22f"
    func fetchWeatherData(for location: CLLocation, completion: @escaping (Result<ResponseData, Error>) -> Void) {
            let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)"
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "WeatherService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "WeatherService", code: 2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }

                do {
                    let weatherData = try JSONDecoder().decode(ResponseData.self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}



