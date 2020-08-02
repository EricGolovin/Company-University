//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Eric Golovin on 02.08.2020.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var notificImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificImageView.image = getImageFromDefaults()
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        notificImageView.image = getImageFromDefaults()
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

extension TodayViewController {
    func getImageFromDefaults() -> UIImage? {
        guard let defaults = UserDefaults(suiteName: "group.com.ericgolovin.Openly.demodata"),
            let imageURL = defaults.url(forKey: "notificationImage"),
            let data = try? Data(contentsOf: imageURL),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }
}
