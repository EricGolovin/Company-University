//
//  UserData.swift
//  UITasks-part02
//
//  Created by Eric Golovin on 06.06.2020.
//  Copyright © 2020 com.ericgolovin. All rights reserved.
//

import UIKit

class UserData: NSObject, Codable {
    var login: String
    var name: String
    var imagePath: String
    
    init(login: String, name: String, imagePath: String) {
        self.login = login
        self.name = name
        self.imagePath = imagePath
    }
}
