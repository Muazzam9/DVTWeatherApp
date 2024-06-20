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
            Text(formatTime(unixTime: viewModel.weather.city.sunrise, timeZoneOffset: viewModel.weather.city.timezone))
            Spacer()
            Text("Sunset")
                .bold()
            Image(systemName: "moon.fill")
                .foregroundColor(Color("DarkBlue"))
            Text(formatTime(unixTime: viewModel.weather.city.sunset, timeZoneOffset: viewModel.weather.city.timezone))
        }
        .font(.body)
        .padding()
        .background(colorSchemeManager.currentScheme == .light ? Color.white : Color(.systemBackground).opacity(0.2))
        .foregroundColor(colorSchemeManager.currentScheme == .dark ? .white : .primary)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
    
    func formatTime(unixTime: Double, timeZoneOffset: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
        return formatter.string(from: date)
    }
}
