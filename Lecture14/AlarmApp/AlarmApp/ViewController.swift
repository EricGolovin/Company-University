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
            registerNotification(title: alarm.title, date: alarm.date)
        }
    }
    
    func registerNotification(title: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Alarm at \(date.getAlarmCellString())"
        content.sound = .defaultCriticalSound(withAudioVolume: 1)
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = Calendar.current.component(.weekday, from: date)
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        dateComponents.minute = Calendar.current.component(.minute, from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
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
