//
//  DailyForecastView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/18.
//

import SwiftUI

struct DailyForecastView: View {
    var dailyForecast: DailyForecast
    
    @StateObject var viewModel: WeatherViewModel
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    
    var body: some View {
        HStack {
            HStack {
                Text(Formatters().formattedTime(from: dailyForecast.day, timeZoneOffset: viewModel.weather.city.timezone) ?? viewModel.day)
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
                Text("\(Formatters().convert(dailyForecast.maxTemp).roundDouble())°")
                Text("\(Formatters().convert(dailyForecast.minTemp).roundDouble())°")
                Spacer()
            }
            .bold()
          
        }
        .padding()
    }
}
