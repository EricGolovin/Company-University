//
//  DateManager.swift
//  WeatherApp
//
//  Created by Eric Golovin on 7/20/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import Foundation

class DateManager {
    static func getFormattedDate(from date: Date, output format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
