//
//  ViewController+PickerView.swift
//  WeatherApp
//
//  Created by Eric Golovin on 7/20/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.cityTextField.text = cities[row]
    }
}
