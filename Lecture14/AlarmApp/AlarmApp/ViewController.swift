//
//  ViewController.swift
//  AlarmApp
//
//  Created by Eric Golovin on 22.07.2020.
//

import UIKit

class ViewController: UIViewController {
    
    enum CellIdentifiers: String {
        case alarm = "AlarmTableViewCell"
        case picker = "DatePickerTableViewCell"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private let count = 4
    
    let notification = Notification.current
    
    lazy var alarms: [AlarmData] = {
        var result: [AlarmData] = []
        for i in 0...count {
            result.append(AlarmData(title: "Alarm #\(i + 1)", date: Date(timeIntervalSinceNow: TimeInterval((i + 1) * 100))))
        }
        return result
    }()
    
    
    var datePickerIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "AlarmTableViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.alarm.rawValue)
        tableView.register(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifiers.picker.rawValue)
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentAlarm()
    }
    
    @IBAction func setAlarmTapped(_ sender: UIButton) {
        for alarm in alarms {
            notification.registerNotification(title: alarm.title, date: alarm.date)
        }
    }
    @IBAction func removeAllAlarmsTapped(_ sender: UIButton) {
        notification.removeAllNotificationRequests()
    }
}


extension ViewController {
    func presentAlarm() {
        let alertController = UIAlertController(title: "Add Alarm", message: "Please, enter alarm name", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Alarm name"
            textField.textAlignment = .center
        })
        
        let action = UIAlertAction(title: "Done", style: .default, handler: { _ in
            guard let text = alertController.textFields?.first?.text else {
                return
            }
            self.alarms.append(AlarmData(title: text, date: Date()))
            self.tableView.reloadData()
        })
        
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
