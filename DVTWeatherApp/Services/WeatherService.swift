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
    
    struct ApiDetails {
        static let API_KEY = "3d919e7f3e82c534fc32fc9e77cdd22f"
        static let BASE_URL = "https://api.openweathermap.org/data/2.5/forecast"
    }
    
    func fetchWeatherData(for location: CLLocation, completion: @escaping (Result<ResponseData, Error>) -> Void) {
        let urlString = "\(ApiDetails.BASE_URL)?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(ApiDetails.API_KEY)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "WeatherService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                log.errorMessage(String(describing: error))
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
                log.errorMessage(String(describing: error))
                completion(.failure(error))
            }
        }.resume()
    }
}



