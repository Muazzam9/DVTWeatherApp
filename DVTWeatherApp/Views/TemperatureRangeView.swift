//
//  TemperatureRangeView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/20.
//

import SwiftUI

struct TemperatureRangeView: View {
    @StateObject var viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            RangeItem(label: "min", temp: viewModel.minTemperature)
            Spacer()
            RangeItem(label: "Current", temp: viewModel.temperature)
            Spacer()
            RangeItem(label: "max", temp: viewModel.maxTemperature)
        }
        .foregroundColor(.white)
        .padding()
        .background(viewModel.backgroundColor.secondary)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
    
    private func RangeItem(label: String, temp: String) -> some View {
        return VStack(alignment: .center) {
            Text(temp)
                .fontWeight(.semibold)
            Text(label)
                .bold()
        }
    }
}

#Preview {
    TemperatureRangeView(viewModel: WeatherViewModel())
}
