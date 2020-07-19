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
    var sunriseTime: String
    var sunsetTime: String

    enum CodingKeys: String, CodingKey {
        case data = "consolidated_weather"
        case sunriseTime = "sun_rise"
        case sunsetTime = "sun_set"
    }
}

struct Weather: Codable {
    var date: String
    var maxTemperature: Double
    var minTemperature: Double
    var currentTemperature: Double
    var humidity: Int
    var windDirection: String
    var windSpeed: Double
    var condition: String
    var stateImageID: String
    
    enum CodingKeys: String, CodingKey {
        case date = "applicable_date"
        case maxTemperature = "max_temp"
        case minTemperature = "min_temp"
        case currentTemperature = "the_temp"
        case windDirection = "wind_direction_compass"
        case windSpeed = "wind_speed"
        case condition = "weather_state_name"
        case stateImageID = "weather_state_abbr"
        case humidity
    }
}

