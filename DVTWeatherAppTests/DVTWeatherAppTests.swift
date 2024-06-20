//
//  DVTWeatherAppTests.swift
//  DVTWeatherAppTests
//
//  Created by Muazzam Aziz on 2024/06/15.
//

import XCTest
import Combine
import CoreLocation
@testable import DVTWeatherApp

final class DVTWeatherAppTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = WeatherViewModel()
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testFetchWeatherSuccess() throws {
        // Given
        let expectation = XCTestExpectation(description: "Fetch weather data successfully")
        let mockLocation = CLLocation(latitude: 40.7128, longitude: -74.0060)
        
        // Mock successful response data
        let responseData = ResponseData(
            cod: "200",
            message: 0,
            cnt: 96,
            list: [ResponseData.ListResponse(
                dt: 1697972400,
                main: ResponseData.MainResponse(temp: 285.45, feelsLike: 284.77, tempMin: 285.45, tempMax: 285.88, pressure: 1006, seaLevel: 1006, groundLevel: 1003, humidity: 78, tempKf: -0.43),
                weather: [ResponseData.WeatherResponse(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")],
                clouds: ResponseData.CloudsResponse(all: 69),
                wind: ResponseData.WindResponse(speed: 2.62, deg: 251, gust: 4.4),
                visibility: 10000,
                pop: 0, rain: nil,
                sys: ResponseData.SysResponse(pod: "d"),
                localTime: "2023-10-22 11:00:00"
            )],
            city: ResponseData.CityResponse(id: 5128581, name: "New York", coord: ResponseData.Coordinations(lat: 40.7128, lon: -74.0060), country: "US", population: 10000000, timezone: -18000, sunrise: 1625115600, sunset: 1625168400)
        )

        // Mock the fetchWeatherData method in WeatherService
        let mockWeatherService = MockWeatherService()
        mockWeatherService.responseData = responseData
        viewModel.weatherService = mockWeatherService
        viewModel.currentLocation = mockLocation

        // When
        viewModel.fetchWeather(isInitialLoad: true)

        // Then
        viewModel.$weather
            .dropFirst()
            .sink { weather in
                XCTAssertEqual(weather.city.name, "New York")
                XCTAssertEqual(weather.list.first?.main.temp, 285.45)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchWeatherFailure() throws {
        // Given
        let expectation = XCTestExpectation(description: "Fetch weather data failure")
        let mockLocation = CLLocation(latitude: 40.7128, longitude: -74.0060)

        // Mock error response
        let mockWeatherService = MockWeatherService()
        mockWeatherService.shouldReturnError = true
        viewModel.weatherService = mockWeatherService
        viewModel.currentLocation = mockLocation

        // When
        viewModel.fetchWeather(isInitialLoad: true)

        // Then
        viewModel.$appError
            .dropFirst()
            .sink { appError in
                XCTAssertNotNil(appError)
                XCTAssertEqual(appError?.errorString, "Failed to fetch weather data")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testTemperatureConversion() throws {
        // Given
        let kelvinTemp: Double = 300.0
        
        // When
        let celsiusTemp = Formatters().convert(kelvinTemp)
        
        // Then
        XCTAssertEqual(celsiusTemp, 26.5, accuracy: 0.1)
    }

    func testFormattedTime() throws {
        // Given
        let dateString = "2024-06-20"
        let timeZoneOffset: Double = 7200.0
        
        // When
        let formattedTime = Formatters().formattedTime(from: dateString, timeZoneOffset: timeZoneOffset)
        
        // Then
        XCTAssertEqual(formattedTime, "Thursday")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

// Mock WeatherService for testing
class MockWeatherService: WeatherService {
    var responseData: ResponseData?
    var shouldReturnError = false

    override func fetchWeatherData(for location: CLLocation, completion: @escaping (Result<ResponseData, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch weather data"])))
        } else if let responseData = responseData {
            completion(.success(responseData))
        }
    }
}
