//
//  IndicatorsView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/18.
//

import SwiftUI

struct IndicatorsView: View {
    @StateObject var viewModel: WeatherViewModel
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Image(systemName: "thermometer.medium")
                    Text("Feels Like")
                        .font(.caption)
                }
                Text(viewModel.feels)
                    .font(.system(size: 25))
            }
            .padding()
            .background(colorSchemeManager.currentScheme == .light ? Color.white : Color(.systemBackground).opacity(0.2))
            .foregroundColor(colorSchemeManager.currentScheme == .dark ? .white : .primary)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            
            Spacer()
            
            VStack {
                HStack {
                    Image(systemName: "humidity")
                    Text("Humidity")
                        .font(.caption)
                }
                Text(viewModel.humidity)
                    .font(.system(size: 25))
            }
            .padding()
            .background(colorSchemeManager.currentScheme == .light ? Color.white : Color(.systemBackground).opacity(0.2))
            .foregroundColor(colorSchemeManager.currentScheme == .dark ? .white : .primary)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            
            Spacer()
            
            VStack {
                HStack {
                    Image(systemName: "wind")
                    Text("Wind")
                        .font(.caption)
                }
                Text(viewModel.wind)
                    .font(.system(size: 25))
            }
            .padding()
            .background(colorSchemeManager.currentScheme == .light ? Color.white : Color(.systemBackground).opacity(0.2))
            .foregroundColor(colorSchemeManager.currentScheme == .dark ? .white : .primary)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
        }
    }
}
