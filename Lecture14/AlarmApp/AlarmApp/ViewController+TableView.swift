//
//  ViewController+TableView.swift
//  AlarmApp
//
//  Created by Eric Golovin on 23.07.2020.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datePickerIndexPath != nil {
            return alarms.count + 1
        }
        return alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let pickerIndexPath = datePickerIndexPath {
            if pickerIndexPath.row == indexPath.row {
                return tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.picker.rawValue, for: indexPath) as! DatePickerTableViewCell
            } else if pickerIndexPath.row < indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.alarm.rawValue, for: indexPath) as! AlarmTableViewCell
                cell.title.text = alarms[indexPath.row - 1].title
                cell.time.text = alarms[indexPath.row - 1].date.getAlarmCellString()
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.alarm.rawValue, for: indexPath) as! AlarmTableViewCell
        cell.title.text = alarms[indexPath.row].title
        cell.time.text = alarms[indexPath.row].date.getAlarmCellString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pickerIndexPath = datePickerIndexPath {
            let pickerCell = tableView.cellForRow(at: pickerIndexPath) as! DatePickerTableViewCell
            alarms[pickerIndexPath.row - 1].date = pickerCell.selectedDate()
            datePickerIndexPath = nil
        } else {
            datePickerIndexPath = calculateDatePickerIndexPath(selectedIndexPath: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if datePickerIndexPath == nil {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            alarms.remove(at: indexPath.row)
        default:
            break
        }
        tableView.reloadData()
    }
    
}

extension ViewController {
    func calculateDatePickerIndexPath(selectedIndexPath: IndexPath) -> IndexPath {
        return IndexPath(row: selectedIndexPath.row + 1, section: 0)
    }
}
