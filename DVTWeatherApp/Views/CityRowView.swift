//
//  CityRowView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/21.
//

import SwiftUI
import WeatherKit
import CoreLocation
import Combine

struct CityRowView: View {
    @StateObject var viewModel: SavedLocationViewModel
    let city: City
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
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
                .frame(maxWidth: .infinity)
                .background(viewModel.backgroundColor)
                .foregroundColor(.white)
            }
        }
    }
}
