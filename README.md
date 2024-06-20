# DVTWeatherApp
![simulator_screenshot_0E38DEE0-AFF6-4640-993E-F352C9AF2463](https://github.com/Muazzam9/DVTWeatherApp/assets/58729460/1a3dea83-bcda-4162-81ef-b331d1de1486)

Welcome to the **DVTWeatherApp**! This is a comprehensive iOS application built using Swift and SwiftUI that provides detailed weather forecasts based on your current location or a specified location.

## Features

- Current weather conditions
- Hourly weather forecast
- Daily weather forecast
- Search for weather by location
- Add locations to favorites
- Automatic location updates

## Getting Started

To run the app on your local machine, follow these steps:

1. **Clone this repository** to your local machine:
    ```bash
    git clone https://github.com/yourusername/DVTWeatherApp.git
    cd DVTWeatherApp
    ```

2. **Install dependencies** using CocoaPods. If you don't have CocoaPods installed, you can install it using:
    ```bash
    sudo gem install cocoapods
    ```
    Then, navigate to the project directory and install the dependencies:
    ```bash
    pod install
    ```

3. **Open the project** in Xcode by opening the `.xcworkspace` file:
    ```bash
    open DVTWeatherApp.xcworkspace
    ```

4. **Set up API keys**:
    - Sign up for an account on [OpenWeatherMap](https://openweathermap.org/) and obtain your API key.
    - Open `WeatherService.swift` and replace `API_KEY` value with your actual API key:
    ```swift
    static let API_KEY = "your-api-key-value"
    ```

5. **Set the location of the simulator**:
    - Open the iOS simulator.
    - In the top menu, go to `Features > Location` and select a location other than `None`.

## Usage

1. Launch the app.
2. Allow location permissions when prompted to get the weather based on your current location.
3. Use the search bar to look for weather in different locations.
4. Add locations to your favorites to easily access their weather information.
5. Pull down to refresh the weather data.

## Dependencies

The app uses the following technologies and libraries:

- Swift
- SwiftUI
- CoreLocation for location services
- Combine for managing asynchronous data streams
- OpenWeatherMap API for fetching weather data

## Testing

The project includes unit tests using XCTest. To run the tests, open the project in Xcode and press `Cmd+U`.

## Known Issues

- Limited API calls per day due to the basic version of the API.

## Future Enhancements

- Improved UI design and styling.
- Additional weather information such as UV index and air quality.
- Better error handling for API calls and user inputs.

## Credits

This app is created by Mu'azzam Aziz.

## Screen Recording


https://github.com/Muazzam9/DVTWeatherApp/assets/58729460/b435efed-b285-4225-8f3e-fff9208459c1


