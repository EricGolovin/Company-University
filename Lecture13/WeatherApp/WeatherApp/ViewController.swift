//
//  ViewController.swift
//  WeatherApp
//
//  Created by Eric Golovin on 7/19/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // TODO: Implement City Search
    
    // MARK: - Outlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var todayDayTemperature: UILabel!
    @IBOutlet weak var todayNightTemperature: UILabel!
    
    @IBOutlet var dayStackViews: [UIStackView]!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeather()
    }


}

private extension ViewController {
    func loadWeather() {
        api.loadWeather { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.cityLabel.text = self.api.currentLocation?.name ?? "None"
                    self.conditionLabel.text = "\(weather.data.first?.condition ?? "")"
                    self.temperatureLabel.text = "\(Int(weather.data.first?.currentTemperature ?? 0.0))°"
                    
                    self.api.loadWeatherStateImage(abbriviation: weather.data.first!.stateImageID, size: .large, to: self.conditionImageView)
                    self.dateLabel.text = self.getFormattedDate(from: weather.data.first!.date, output: "MMM dd")
//                    getFormattedDate(from: weather.data.first!.date, format: ("yyyy-MM-dd", "MMM dd")) ?? "None"
                    self.todayDayTemperature.text = "D: \(Int(weather.data.first?.maxTemperature ?? 0.0))"
                    self.todayDayTemperature.textColor = .red
                    self.todayNightTemperature.text = "N: \(Int(weather.data.first?.minTemperature ?? 0.0))"
                    self.todayNightTemperature.textColor = .blue
                    
                    self.sunriseLabel.text = self.getFormattedDate(from: weather.sunriseDate, output: "H:m")
//                    getFormattedDate(from: weather.sunriseTime, format: ("yyyy-MM-dd'T'HH:mm:ss.SSSXXX", "H:m")) ?? "None"
                    self.sunsetLabel.text = self.self.getFormattedDate(from: weather.sunsetDate, output: "H:m")
//                    getFormattedDate(from: weather.sunsetTime, format: ("yyyy-MM-dd'T'HH:mm:ss.SSSXXX", "H:m")) ?? "None"
                    
                    self.windSpeedLabel.text = "\(weather.data.first?.windDirection ?? "None") \(Int(weather.data.first?.windSpeed ?? 0.0)) km/h"
                    self.humidityLabel.text = "\(weather.data.first?.humidity ?? 0)%"
                    
                    for (index, stack) in self.dayStackViews.enumerated() {
                        print(index)
                        self.set(weather: weather.data[index + 1], for: stack)
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

private extension ViewController {
    func getFormattedDate(from date: Date, output format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    func set(weather: Weather, for dayStack: UIStackView) {
        if let stackView = dayStack.arrangedSubviews[0] as? UIStackView {
            guard let dayLabel = stackView.arrangedSubviews.first as? UILabel,
                let dayConditionImageView = stackView.arrangedSubviews.last as? UIImageView else { return }
            dayLabel.text = getFormattedDate(from: weather.date, output: "EEEE")
                //getFormattedDate(from: weather.date, format: ("yyyy-MM-dd", "EEEE")) ?? "None"
            api.loadWeatherStateImage(abbriviation: weather.stateImageID, size: .small, to: dayConditionImageView)
        }
        
        if let minLabel = dayStack.arrangedSubviews[1] as? UILabel {
            minLabel.text = "D: \(Int(weather.maxTemperature))"
            minLabel.textColor = .red
        }
        
        if let maxLabel = dayStack.arrangedSubviews[2] as? UILabel {
            maxLabel.text = "N: \(Int(weather.maxTemperature))"
            maxLabel.textColor = .blue
        }
    }
}
