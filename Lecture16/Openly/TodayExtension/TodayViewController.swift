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
    @IBOutlet weak var acceptCountLabel: UILabel!
    @IBOutlet weak var rejectCountLabel: UILabel!
    @IBOutlet weak var labelsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        configureUI()
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            labelsStackView.heightAnchor.constraint(equalToConstant: maxSize.height).isActive = true
            self.preferredContentSize = maxSize
        case .expanded:
            self.preferredContentSize = CGSize(width: maxSize.width, height: 300)
        @unknown default:
            fatalError()
        }
    }
    
    func configureUI() {
        notificImageView.image = getImageFromDefaults()
        
        if let scoreData = getScoreFromDefaults() {
           acceptCountLabel.text = "\(scoreData.accepted)"
            rejectCountLabel.text = "\(scoreData.rejected)"
        }
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
    
    func getScoreFromDefaults() -> (accepted: Int, rejected: Int)? {
        guard let defaults = UserDefaults(suiteName: "group.com.ericgolovin.Openly.demodata") else { return nil }
        
        let accepted = defaults.integer(forKey: "numAccepted")
        let regected = defaults.integer(forKey: "numRejected")
        
        return (accepted, regected)
    }
}
