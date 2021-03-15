//
//  API+Extensions.swift
//  WeatherApp
//
//  Created by Daniil Akmatov on 12/3/21.
//

import Foundation

extension API {
    static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    
    static func getURLFor(lat: Double, lon: Double) -> String {
        return "\(baseURLString)oncall?lat=\(lat)&lon\(lon)&exclude=minutely&appid=\(key)&units=imperial"
    }
}
