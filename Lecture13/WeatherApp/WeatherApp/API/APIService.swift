//
//  APIService.swift
//  WeatherApp
//
//  Created by Eric Golovin on 7/19/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import Foundation

public enum HTTPStatusCodes: Int {
    case success = 200 // success
    case created = 201 // created
    case internalServerError = 500
}

enum CityID: String {
    case sanFrancisco = "san"
    case london = "london"
    case kharkiv = "kharkiv"
    
    init(name: String) {
        switch name {
        case "Kharkiv":
            self = .kharkiv
        case "London":
            self = .london
        case "San-Francisco":
            self = .sanFrancisco
        default:
            fatalError()
        }
    }
}

enum CodeValidation {
    case success
    case internalServerError
    case unknown
}

enum ServiceError: Error {
    case message(errorMessage: String)
    case undefined
}

protocol CodeHandlerProtocol {
    func handleServerCodes(_ code: Int, completion: @escaping (_ result: CodeValidation) -> Void)
}

class APIService {
    static let api = "https://www.metaweather.com"
    let availableCities = ["Kharkiv", "London", "San-Francisco"]
}

extension APIService: CodeHandlerProtocol {
    
    func handleServerCodes(_ code: Int, completion: @escaping (_ result: CodeValidation) -> Void) {
        switch HTTPStatusCodes(rawValue: code) {
        case .success?, .created?:
            completion(.success)
            
        case .internalServerError?:
            completion(.internalServerError)
            
        default:
            completion(.unknown)
        }
    }
}
