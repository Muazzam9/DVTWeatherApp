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
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    CurrentWeatherView(viewModel: viewModel)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.weather.list, id: \.self) { hourly in
                                HourlyForecastView(weatherList: hourly, weather: viewModel.weather, viewModel: viewModel)
                            }
                        }
                    }
                    
                    SunriseView(viewModel: viewModel)
                    
                    IndicatorsView(viewModel: viewModel)
                    
                    let sortedDailyForecasts = viewModel.dailyForecasts.sorted { $0.day < $1.day }
                    
                    VStack(alignment: .leading) {
                        ForEach(sortedDailyForecasts, id: \.day) { daily in
                            DailyForecastView(dailyForecast: daily, viewModel: viewModel)
                        }
                    }
                    .background(colorSchemeManager.currentScheme == .light ? Color.white : Color(.systemBackground).opacity(0.2))
                    .foregroundColor(colorSchemeManager.currentScheme == .dark ? .white : .primary)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                }
                .padding()
                .aspectRatio(1.0, contentMode: .fill)
            }
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
}
