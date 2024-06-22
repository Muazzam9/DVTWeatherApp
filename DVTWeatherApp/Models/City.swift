//
//  City.swift
//  DVTWeatherApp
//
//  Created by Muazzam Aziz on 2024/06/21.
//


import Foundation
import CoreLocation

struct City: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
