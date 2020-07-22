//
//  DateExtensions.swift
//  AlarmApp
//
//  Created by Eric Golovin on 23.07.2020.
//

import UIKit

public extension Date {
    func getAlarmCellString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
