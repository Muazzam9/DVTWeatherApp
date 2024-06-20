//
//  SunriseView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/18.
//

import SwiftUI

struct SunriseView: View {
    @StateObject var viewModel: WeatherViewModel
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    
    var body: some View {
        HStack {
            Text("Sunrise")
                .bold()
            Image(systemName: "sun.max.fill")
                .renderingMode(.original)
            Text(Formatters().formatTime(unixTime: viewModel.weather.city.sunrise, timeZoneOffset: viewModel.weather.city.timezone))
            Spacer()
            Text("Sunset")
                .bold()
            Image(systemName: "moon.fill")
                .foregroundColor(Color(hex: "#003087"))
            Text(Formatters().formatTime(unixTime: viewModel.weather.city.sunset, timeZoneOffset: viewModel.weather.city.timezone))
        }
        .foregroundColor(.white)
        .font(.body)
        .padding()
        .background(viewModel.backgroundColor.secondary)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

#Preview {
    SunriseView(viewModel: WeatherViewModel())
        .environmentObject(ColorSchemeManager())
}
