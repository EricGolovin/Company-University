//
//  PasswordChecker.swift
//  UITasks-part02
//
//  Created by Eric Golovin on 06.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import Foundation

struct PasswordChecker {
    private var letters = "abcdefghijklmnopqrstuvwxyz"
    private var numbers = "0123456789"
    
    func check(password: String) -> Bool {
        print(password)
        for char in password.lowercased() {
            print("Char: \(char) \(letters.contains(char))")
            if !letters.contains(char) && !numbers.contains(char) {
                return false
            }
        }
        return true
    }
}
