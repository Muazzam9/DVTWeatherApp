//
//  ContentView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/16.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    
    var body: some View {
        ZStack {
            BackgroundView
            VStack {
                CurrentWeatherView(viewModel: viewModel)
                TemperatureRangeView(viewModel: viewModel)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 15) {
                        HourlyForecastScrollView
                        SunriseView(viewModel: viewModel)
                        IndicatorsView(viewModel: viewModel)
                        DailyForecastListView
                    }
                    .aspectRatio(1.0, contentMode: .fill)
                }
                .refreshable {
                    viewModel.fetchWeather(isInitialLoad: false)
                }
            }
            .padding()
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .background(Color(.systemBackground).opacity(0.8))
        .environment(\.colorScheme, colorSchemeManager.currentScheme)
    }
}

extension WeatherView {
    @ViewBuilder
    private var BackgroundView: some View {
        viewModel.backgroundColor
            .edgesIgnoringSafeArea(.all)
        
        if let backgroundImage = viewModel.backgroundImage {
            backgroundImage
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .top)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    @ViewBuilder
    private var HourlyForecastScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.weather.list, id: \.self) { hourly in
                    HourlyForecastView(weatherList: hourly, weather: viewModel.weather, viewModel: viewModel)
                }
            }
        }
    }
    
    @ViewBuilder
    private var DailyForecastListView: some View {
        let sortedDailyForecasts = viewModel.dailyForecasts.sorted { $0.day < $1.day }
        
        VStack(alignment: .leading) {
            ForEach(sortedDailyForecasts, id: \.day) { daily in
                DailyForecastView(dailyForecast: daily, viewModel: viewModel)
            }
        }
        .background(viewModel.backgroundColor.secondary)
        .background(.ultraThickMaterial)
        .cornerRadius(20)
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel())
        .environmentObject(ColorSchemeManager())
        .environment(\.colorScheme, ColorSchemeManager().currentScheme)
}
