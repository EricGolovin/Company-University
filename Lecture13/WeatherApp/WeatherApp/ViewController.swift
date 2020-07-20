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

    @IBAction func userDoubleTapped(_ sender: UITapGestureRecognizer) {
        loadWeather()
    }
    
}

private extension ViewController {
    func loadWeather() {
        api.loadWeather { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.updateUI(with: weather)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

private extension ViewController {
    
    func updateUI(with weather: WeatherForDay) {
        guard let data = weather.data.first,
            let currentLocation = self.api.currentLocation else { return }
        var formattedDate = ""
        let animation: UIView.AnimationOptions = .transitionCrossDissolve
        
        conditionLabel.changeText(to: data.condition, duration: 2, option: animation)
        temperatureLabel.changeText(to: "\(Int(data.currentTemperature))°", duration: 2, option: animation)
        cityLabel.changeText(to: currentLocation.name, duration: 2, option: animation)
        
        api.loadWeatherStateImage(abbriviation: weather.data.first!.stateImageID, size: .large, to: conditionImageView)
        
        formattedDate = DateManager.getFormattedDate(from: weather.data.first!.date, output: "MMM dd")
        dateLabel.changeText(to: formattedDate, duration: 2, option: animation)
        
        todayDayTemperature.changeText(to: "D: \(Int(data.maxTemperature))", duration: 2, option: animation)
        todayDayTemperature.textColor = .red
        
        todayNightTemperature.changeText(to: "N: \(Int(data.minTemperature))", duration: 2, option: animation)
        todayNightTemperature.textColor = .blue
        
        formattedDate = DateManager.getFormattedDate(from: weather.sunriseDate, output: "H:m")
        sunriseLabel.changeText(to: formattedDate, duration: 2, option: animation)
        
        formattedDate = DateManager.getFormattedDate(from: weather.sunsetDate, output: "H:m")
        sunsetLabel.changeText(to: formattedDate, duration: 2, option: animation)
        
        windSpeedLabel.changeText(to: "\(data.windDirection) \(Int(data.windSpeed)) km/h", duration: 2, option: animation)
        humidityLabel.changeText(to: "\(data.humidity)%", duration: 2, option: animation)
        
        for (index, stack) in dayStackViews.enumerated() {
            print(index)
            set(weather: weather.data[index + 1], for: stack)
        }
    }
    
    func set(weather: Weather, for dayStack: UIStackView) {
        
        let animation: UIView.AnimationOptions = .transitionFlipFromRight
        
        if let stackView = dayStack.arrangedSubviews[0] as? UIStackView {
            guard let dayLabel = stackView.arrangedSubviews.first as? UILabel,
                let dayConditionImageView = stackView.arrangedSubviews.last as? UIImageView else { return }
            let formattedDate = DateManager.getFormattedDate(from: weather.date, output: "EEEE")
            dayLabel.changeText(to: formattedDate, duration: 2, option: animation)
            api.loadWeatherStateImage(abbriviation: weather.stateImageID, size: .small, to: dayConditionImageView)
        }
        
        if let minLabel = dayStack.arrangedSubviews[1] as? UILabel {
            minLabel.changeText(to: "D: \(Int(weather.maxTemperature))", duration: 2, option: animation)
            minLabel.textColor = .red
        }
        
        if let maxLabel = dayStack.arrangedSubviews[2] as? UILabel {
            maxLabel.changeText(to: "N: \(Int(weather.maxTemperature))", duration: 2, option: animation)
            maxLabel.textColor = .blue
        }
    }
}

extension UILabel {
    func changeText(to text: String, duration: Double, option: UIView.AnimationOptions) {
        UIView.transition(with: self, duration: duration, options: option, animations: {
            self.text = text
        }, completion: nil)
    }
}
