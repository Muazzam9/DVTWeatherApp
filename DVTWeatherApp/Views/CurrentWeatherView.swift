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
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(formatedTime(time: Date.now, timeZoneOffset: viewModel.weather.city.timezone))
                    .font(.caption2)
                    .bold()
                Text(viewModel.temperature)
                    .font(.system(size: 40))
                Text(viewModel.weather.city.name)
                    .font(.body)
                    .bold()
            }
            Spacer()
            viewModel.weatherIcon(for: viewModel.main)
                
                .font(.system(size: 50))
                .shadow(radius: 5)
        }
        .padding()
        .background(colorSchemeManager.currentScheme == .light ? Color.white : Color(.systemBackground).opacity(0.2))
        .foregroundColor(colorSchemeManager.currentScheme == .dark ? .white : .primary)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
}
    
    func formatedTime(time: Date, timeZoneOffset: Double) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E, HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timeZoneOffset))
        return formatter.string(from: date)
    }
}
