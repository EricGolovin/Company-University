//
//  ViewController.swift
//  Openly
//
//  Created by Eric Golovin on 30.07.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var acceptLabel: UILabel!
    @IBOutlet weak var regectLabel: UILabel!
    
    private var numAccepted = 0 {
        didSet {
            self.acceptLabel.text = "\(numAccepted)"
        }
    }
    
    private var numRejected = 0 {
        didSet {
            self.regectLabel.text = "\(numRejected)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedData = getScoreFromDefaults() {
            acceptLabel.text = "\(loadedData.accepted)"
            regectLabel.text = "\(loadedData.rejected)"
        }
        
        
        Notification.Name.acceptButton.onPost { [weak self] _ in
            guard let self = self else { return }
            self.numAccepted += 1
            self.writeToDefauld(data: self.numAccepted, with: "numAccepted")
        }
        
        Notification.Name.rejectButton.onPost { [weak self] _ in
            guard let self = self else { return }
            self.numRejected += 1
            self.writeToDefauld(data: self.numRejected, with: "numRejected")
        }
    }
}

extension ViewController {
    func writeToDefauld(data: Int, with key: String) {
        guard let defaults = UserDefaults(suiteName: "group.com.ericgolovin.Openly.demodata") else {
            return
        }
        defaults.set(data, forKey: key)
    }
    
    func getScoreFromDefaults() -> (accepted: Int, rejected: Int)? {
        guard let defaults = UserDefaults(suiteName: "group.com.ericgolovin.Openly.demodata") else { return nil }
        
        let accepted = defaults.integer(forKey: "numAccepted")
        let regected = defaults.integer(forKey: "numRejected")
        
        return (accepted, regected)
    }
}

