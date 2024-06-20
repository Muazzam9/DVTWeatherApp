//
//  DailyForecastView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/18.
//

import SwiftUI

struct DailyForecastView: View {
    var dailyForecast: WeatherViewModel.DailyForecast
    
    @StateObject var viewModel: WeatherViewModel
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    
    var body: some View {
        HStack {
            HStack {
                Text(viewModel.formattedTime(from: dailyForecast.day, timeZoneOffset: viewModel.weather.city.timezone) ?? viewModel.day)
                Spacer()
            }
            Spacer()
            HStack {
                viewModel.weatherIcon(for: dailyForecast.main)
                    .renderingMode(.template)
                    .foregroundColor(.red)
                    .shadow(radius: 5)
                Text(dailyForecast.main)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Text("\(viewModel.convert(dailyForecast.maxTemp).roundDouble())°")
                Text("\(viewModel.convert(dailyForecast.minTemp).roundDouble())°")
                Spacer()
            }
            .bold()
          
        }
        .padding()
    }
}
