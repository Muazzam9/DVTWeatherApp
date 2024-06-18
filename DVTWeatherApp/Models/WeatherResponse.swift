//
//  WeatherResponse.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/16.
//

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
}
