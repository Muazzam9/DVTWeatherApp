//
//  AppError.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/20.
//

import Foundation

struct AppError: Identifiable {
    let id = UUID().uuidString
    let errorString: String
}
