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
typealias LocationComplition = (_ result: ServiceResult<Location?, ServiceError>) -> Void

protocol WeatherAPIServiceRequest {
    func loadLocation(_ completion: @escaping LocationComplition)
    func loadWeather(_ completion: @escaping WeatherComplition)
}

extension APIService: WeatherAPIServiceRequest {
    
    func loadLocation(_ completion: @escaping LocationComplition) {
        guard let url = URL(string: "\(APIService.api)/api/location/search/?query=kharkiv") else {
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
    
    func loadWeather(_ completion: @escaping WeatherComplition) {
        guard let location = self.currentLocation,
            let url = URL(string: "\(APIService.api)/api/location/\(location.id)/") else {
                loadLocation { [weak self] result in
                    switch result {
                    case .success(let location):
                        self?.currentLocation = location
                        self?.loadWeather { result in
                            completion(result)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                return
        }
        
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
    
    func loadWeatherStateImage(abbriviation: String, size: WeatherImageSize, to imageView: UIImageView) {
        guard let url = URL(string: "\(APIService.api)/static/img/weather/png\(size.rawValue)/\(abbriviation).png") else { return }
        print("\(APIService.api)/\(size.rawValue)/\(abbriviation).png")
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            self.handleServerCodes(httpResponse.statusCode) { validation in
                switch validation {
                case .success:
                    guard let data = data,
                        let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                    
                case .internalServerError:
                    print("internalServerError")
                case .unknown:
                    print("unknown")
                }
            }
        }).resume()
    }
    
    
}
