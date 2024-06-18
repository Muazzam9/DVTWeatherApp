//
//  ContentView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(formatedTime(time: Date.now))
                        .font(.caption2)
                        .bold()
                    Text("\(ContentView.numberFormatter.string(for: convert(viewModel.currentWeather?.main.temp ?? 0.0)) ?? "")°")
                        .font(.system(size: 40))
                    Text(viewModel.currentWeather?.name ?? "")
                        .font(.body)
                        .bold()
                }
                Spacer()
//                viewModel.weatherIcon(for: viewModel.main)
//                    .renderingMode(.original)
//                    .font(.system(size: 50))
//                    .shadow(radius: 5)
            }
            .padding()
//            .background(colorSchemeManager.currentScheme == .light ? Color.white : Color(.systemBackground).opacity(0.2))
//            .foregroundColor(colorSchemeManager.currentScheme == .dark ? .white : .primary)
            .background(.ultraThinMaterial)
            .cornerRadius(20)

            if !viewModel.forecast.isEmpty {
                // Current day's forecast in horizontal scroll
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.forecast.prefix(8)) { forecast in
                            VStack {
                                Text(forecast.dt_txt)
                                    .font(.subheadline)
                                Image(systemName: forecast.weather.first?.icon ?? "cloud")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text("\(Int(forecast.main.temp))°C")
                                    .font(.title)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                // Remaining days' forecast in list
//                List {
//                    ForEach(viewModel.forecast.dropFirst(8).chunked(into: 8), id: \.self) { dayForecast in
//                        VStack(alignment: .leading) {
//                            Text(dayForecast.first?.dt_txt.prefix(10) ?? "")
//                                .font(.headline)
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 20) {
//                                    ForEach(dayForecast) { forecast in
//                                        VStack {
//                                            Text(forecast.dt_txt.suffix(8))
//                                                .font(.subheadline)
//                                            Image(systemName: forecast.weather.first?.icon ?? "cloud")
//                                                .resizable()
//                                                .frame(width: 50, height: 50)
//                                            Text("\(Int(forecast.main.temp))°C")
//                                                .font(.title)
//                                        }
//                                        .padding()
//                                        .background(Color.blue.opacity(0.1))
//                                        .cornerRadius(10)
//                                    }
//                                }
//                                .padding(.horizontal)
//                            }
//                        }
//                    }
//                }
            } else {
                Text("Loading weather data...")
            }
        }

    }
    func formatedTime(time: Date) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "E, HH:mm"
        return formatter.string(from: date)
    }
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        return celsius
        
    }
    static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }

}

#Preview {
    ContentView()
}
