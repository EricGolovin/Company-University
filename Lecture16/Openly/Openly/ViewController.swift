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
        
        Notification.Name.acceptButton.onPost { [weak self] _ in
            self?.numAccepted += 1
            
            if let self = self {
                self.writeToDefauld(data: self.numAccepted, with: "numAccepted")
            }
            
        }
        
        Notification.Name.rejectButton.onPost { [weak self] _ in
            self?.numRejected += 1
            
            if let self = self {
                self.writeToDefauld(data: self.numRejected, with: "numRejected")
            }
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
}

