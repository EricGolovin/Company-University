//
//  Name.swift
//  Animation-HW
//
//  Created by Eric Golovin on 6/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import Foundation

struct Name {
    private static let names = ["Rory Carson", "Rahul Spears", "Tia Ayers", "Marni Sexton", "Yaqub Sandoval", "Dawson Johns", "Haider Lowry", "Shelbie Strong", "Ciara Meyer", "Leticia Phan", "Om Barron", "Cherish Cullen", "Zunairah Hilton", "Mathias Parra", "Anaya Terry", "Madihah Corrigan", "Cassian Southern", "Avneet Mcintyre", "Igor Collier", "Sanaya Hayward"]
    
    static func getRandomName() -> String {
        return names[Int.random(in: 0..<names.count)]
    }
}
