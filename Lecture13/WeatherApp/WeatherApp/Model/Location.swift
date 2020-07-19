//
//  Location.swift
//  WeatherApp
//
//  Created by Eric Golovin on 7/19/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import Foundation

struct Location: Codable {
    var name: String
    var type: String
    var id: Int
    var coordinates: String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case type = "location_type"
        case id = "woeid"
        case coordinates = "latt_long"
    }
}
