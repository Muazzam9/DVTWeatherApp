//
//  HourlyForecastView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/18.
//

import SwiftUI

import SwiftUI

struct HourlyForecastView: View {
    @State var weatherList: ResponseData.ListResponse
    @State var weather: ResponseData
    
    @ObservedObject var viewModel: WeatherViewModel
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    
    var body: some View {
        VStack(spacing: 10) {
            Text(Formatters().formattedHourlyTime(time: weatherList.dt, timeZoneOffset: weather.city.timezone))
                .font(.caption2)
            viewModel.weatherIcon(for: weatherList.weather[0].main)
                .renderingMode(.original)
                .shadow(radius: 3)
            Text("\(Formatters().convert(weatherList.main.temp).roundDouble())°")
                .bold()
            HStack(spacing: 5) {
                Image(systemName: "drop.fill")
                    .renderingMode(.original)
//                    .foregroundColor(Color("Blue"))

                Text((weatherList.main.humidity.roundDouble()) + "%")
            }
            .font(.caption)
        }
        .frame(minWidth: 10, minHeight: 80)
        .padding()
        .background(colorSchemeManager.currentScheme == .light ? Color.white : Color(.systemBackground).opacity(0.2))
        .foregroundColor(colorSchemeManager.currentScheme == .dark ? .white : .primary)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}
