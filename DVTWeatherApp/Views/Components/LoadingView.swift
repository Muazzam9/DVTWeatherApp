//
//  LoadingView.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/18.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomSpinner()
                    .frame(width: 100, height: 100)
                Text("Loading...")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .cornerRadius(20)
            .shadow(radius: 10)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CustomSpinner: View {
    @State private var isAnimating: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<8) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 8, height: geometry.size.height / 8)
                        .scaleEffect(!isAnimating ? 1 - CGFloat(index) / 8 : 0.2 + CGFloat(index) / 8)
                        .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                        .foregroundColor(.white)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(!isAnimating ? .degrees(0) : .degrees(360))
                .animation(Animation
                            .timingCurve(0.5, 0.15 + Double(index) / 20, 0.25, 1, duration: 1.5)
                            .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    LoadingView()
}
