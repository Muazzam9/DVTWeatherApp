//
//  CurrentWeatherView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/18.
//

import SwiftUI
import CoreLocation

struct CurrentWeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(Formatters().formatedTime(time: Date.now, timeZoneOffset: viewModel.weather.city.timezone))
                .font(.caption)
                .bold()
            Text(viewModel.temperature)
                .font(.largeTitle)
            Text(viewModel.weather.city.name)
                .font(.headline)
                .bold()
        }
        .foregroundColor(.white)
        
    }
}

#Preview {
    CurrentWeatherView(viewModel: WeatherViewModel())
        .environmentObject(ColorSchemeManager())
}
