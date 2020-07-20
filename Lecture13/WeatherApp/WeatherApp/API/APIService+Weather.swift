//
//  APIService+Weather.swift
//  WeatherApp
//
//  Created by Eric Golovin on 7/19/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

enum ServiceResult<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
    
    
    public init(_ value: Value) {
        self = .success(value)
    }
    
    public init(_ error: Error) {
        self = .failure(error)
    }
}

enum WeatherImageSize: String {
    case small = ""
    case large = "/64"
}

typealias WeatherComplition = (_ result: ServiceResult<WeatherForDay, ServiceError>) -> Void
typealias LocationComplition = (_ result: ServiceResult<Location, ServiceError>) -> Void
typealias ConditionImageComplition = (_ result: ServiceResult<UIImage, ServiceError>) -> Void

protocol WeatherAPIServiceRequest {
    func loadLocation(name: String, _ completion: @escaping LocationComplition)
    func loadWeather(location: Location, _ completion: @escaping WeatherComplition)
}

extension APIService: WeatherAPIServiceRequest {
    
    func loadLocation(name: String, _ completion: @escaping LocationComplition) {
        guard let url = URL(string: "\(APIService.api)/api/location/search/?query=\(CityID(name: name).rawValue)") else {
            return
        }
        print("\(APIService.api)/api/location/search/?query=kharkiv")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            self.handleServerCodes(httpResponse.statusCode) { validation in
                
                switch validation {
                case .success:
                    guard let data = data else { return }
                    
                    do {
                        let location = try JSONDecoder().decode([Location].self, from: data)
                        completion(ServiceResult(location[0]))
                    } catch {
                        completion(ServiceResult(ServiceError.message(errorMessage: error.localizedDescription)))
                    }
                case .internalServerError:
                    print("internalServerError")
                case .unknown:
                    print("unknown")
                }
            }
        }
        task.resume()
    }
    
    func loadWeather(location: Location, _ completion: @escaping WeatherComplition) {
        
        guard let url = URL(string: "\(APIService.api)/api/location/\(location.id)/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            self.handleServerCodes(httpResponse.statusCode) { validation in
                switch validation {
                case .success:
                    guard let data = data else { return }
                    
                    do {
                        let weather = try JSONDecoder().decode(WeatherForDay.self, from: data)
                        print("WeatherDataCount:\(weather.data.count)")
                        completion(ServiceResult(weather))
                    } catch {
                        completion(ServiceResult(ServiceError.message(errorMessage: error.localizedDescription)))
                    }
                case .internalServerError:
                    print("internalServerError")
                case .unknown:
                    print("unknown")
                    
                }
            }
        }
        
        task.resume()
    }
    
    func getWeather(city: String, _ completion: @escaping (WeatherForDay) -> Void) {
        loadLocation(name: city) { locationResult in
            switch locationResult {
            case .success(let locationValue):
                self.loadWeather(location: locationValue) { weatherResult in
                    switch weatherResult {
                    case .success(let weatherResult):
                        completion(weatherResult)
                    case .failure(let reason):
                        print(reason)
                    }
                }
            case .failure(let reason):
                print(reason)
            }
        }
    }
    
    func loadWeatherConditionImage(abbriviation: String, size: WeatherImageSize, _ completion: @escaping ConditionImageComplition) {
        guard let url = URL(string: "\(APIService.api)/static/img/weather/png\(size.rawValue)/\(abbriviation).png") else { return }
        print("\(APIService.api)/\(size.rawValue)/\(abbriviation).png")
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            self.handleServerCodes(httpResponse.statusCode) { validation in
                switch validation {
                case .success:
                    guard let data = data,
                        let image = UIImage(data: data) else { return }
                    completion(ServiceResult(image))
                case .internalServerError:
                    print("internalServerError")
                case .unknown:
                    print("unknown")
                }
            }
        }).resume()
    }
    
    
}
