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
            
            let defaults = UserDefaults(suiteName: "group.com.ericgolovin.Openly.demodata")
                let imageURL = defaults!.url(forKey: "notificationImage")!
                let data = try! Data(contentsOf: imageURL)
                let _ = UIImage(data: data)// else { return }
            
            print("Yeas!")
        }
        
        Notification.Name.rejectButton.onPost { [weak self] _ in
            self?.numRejected += 1
        }
    }

    

}

