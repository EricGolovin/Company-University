//
//  LocationWeather.swift
//  WeatherApp
//
//  Created by Eric Golovin on 7/19/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import Foundation

struct WeatherForDay: Codable {
    var data: [Weather]
    var sun_rise: String
    var sun_set: String

    enum CodingKeys: String, CodingKey {
        case data = "consolidated_weather"
        case sun_rise, sun_set
    }
    
    var sunriseDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        
        return dateFormatter.date(from: sun_rise)!
    }
    
    var sunsetDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        
        return dateFormatter.date(from: sun_set)!
    }
}

struct Weather: Codable {
    var applicable_date: String
    var maxTemperature: Double
    var minTemperature: Double
    var currentTemperature: Double
    var humidity: Int
    var windDirection: String
    var windSpeed: Double
    var condition: String
    var stateImageID: String
    
    enum CodingKeys: String, CodingKey {
        case maxTemperature = "max_temp"
        case minTemperature = "min_temp"
        case currentTemperature = "the_temp"
        case windDirection = "wind_direction_compass"
        case windSpeed = "wind_speed"
        case condition = "weather_state_name"
        case stateImageID = "weather_state_abbr"
        case applicable_date, humidity
    }
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: applicable_date)!
    }
}

