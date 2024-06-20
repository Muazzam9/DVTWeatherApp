//
//  ObjectFactory.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/18.
//

import Foundation
struct ObjectFactory {
    static let responseData = ResponseData(
        cod: "200",
        message: 0.0,
        cnt: 40,
        list: [
            ResponseData.ListResponse(
                dt: 1625155200,
                main: ResponseData.MainResponse(
                    temp: 298.15,
                    feelsLike: 298.65,
                    tempMin: 296.15,
                    tempMax: 300.15,
                    pressure: 1013,
                    seaLevel: 1013,
                    groundLevel: 1009,
                    humidity: 65,
                    tempKf: 1.5
                ),
                weather: [
                    ResponseData.WeatherResponse(
                        id: 800,
                        main: "Clear",
                        description: "clear sky",
                        icon: "01d"
                    )
                ],
                clouds: ResponseData.CloudsResponse(all: 1),
                wind: ResponseData.WindResponse(
                    speed: 5.14,
                    deg: 200,
                    gust: 7.2
                ),
                visibility: 10000,
                pop: 0.0,
                rain: nil,
                sys: ResponseData.SysResponse(pod: "d"),
                localTime: "2024-06-16 21:00:00"
            ),
            ResponseData.ListResponse(
                dt: 1625166000,
                main: ResponseData.MainResponse(
                    temp: 299.15,
                    feelsLike: 299.65,
                    tempMin: 297.15,
                    tempMax: 301.15,
                    pressure: 1012,
                    seaLevel: 1012,
                    groundLevel: 1008,
                    humidity: 60,
                    tempKf: 1.5
                ),
                weather: [
                    ResponseData.WeatherResponse(
                        id: 801,
                        main: "Partly Cloudy",
                        description: "partly cloudy",
                        icon: "02d"
                    )
                ],
                clouds: ResponseData.CloudsResponse(all: 40),
                wind: ResponseData.WindResponse(
                    speed: 4.14,
                    deg: 190,
                    gust: 6.2
                ),
                visibility: 10000,
                pop: 0.0,
                rain: nil,
                sys: ResponseData.SysResponse(pod: "d"),
                localTime: "2024-06-16 24:00:00"
            ),
            // Add more ListResponse items as needed
        ],
        city: ResponseData.CityResponse(
            id: 123456,
            name: "Sample City",
            coord: ResponseData.Coordinations(
                lat: 35.6895,
                lon: 139.6917
            ),
            country: "JP",
            population: 1000000,
            timezone: 32400,
            sunrise: 1625115600,
            sunset: 1625168400
        )
    )
    
}

