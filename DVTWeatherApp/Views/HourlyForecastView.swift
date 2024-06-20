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
                    .foregroundColor(Color(hex: "#32AAE1"))

                Text((weatherList.main.humidity.roundDouble()) + "%")
            }
            .font(.caption)
        }
        .foregroundColor(.white)
        .frame(minWidth: 10, minHeight: 80)
        .padding()
        .background(viewModel.backgroundColor.secondary)
        .background(.ultraThickMaterial)
        .cornerRadius(20)
    }
}

#Preview {
    HourlyForecastView(weatherList: defaultResponseData.list[0], weather: defaultResponseData, viewModel: WeatherViewModel())
        .environmentObject(ColorSchemeManager())
}
