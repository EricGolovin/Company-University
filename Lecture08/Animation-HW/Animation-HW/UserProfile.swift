//
//  UserProfile.swift
//  Animation-HW
//
//  Created by Eric Golovin on 6/18/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class UserProfile {
    enum URLs: String {
        case animal_720 = "https://source.unsplash.com/480x480/?cat"
    }
    
    enum FlipSide {
        case left
        case right
    }
    
    private var userCashedData = [(image: UIImage, title: String)]()
    private var backCounter = 0
    
    private func change(imageView: UIImageView, label: UILabel, to pair: (image: UIImage, title: String), side: FlipSide) {
        let imageFlipSide: UIView.AnimationOptions = (side == .left ? UIView.AnimationOptions.transitionFlipFromLeft : UIView.AnimationOptions.transitionFlipFromRight)
        let labelFlipSide: UIView.AnimationOptions = (side == .left ? UIView.AnimationOptions.transitionFlipFromBottom : UIView.AnimationOptions.transitionFlipFromTop)
        
        UIView.transition(with: imageView, duration: 1.0, options: [imageFlipSide], animations: {
            imageView.image = pair.image
        })
        UIView.transition(with: label, duration: 1, options: [labelFlipSide], animations: {
            label.alpha = 0.0
            label.text = pair.title
        })
        UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [], animations: {
            label.alpha = 1
        }, completion: nil)
    }
    
    func loadNextImage(to imageView: UIImageView, with label: UILabel) {
        if backCounter == 0 {
            let dataTask = URLSession.shared.dataTask(with: URL(string: URLs.animal_720.rawValue)!, completionHandler: { data, response, error in
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                
                let newDataPair = (image: image, title: Name.getRandomName())
                self.userCashedData.append(newDataPair)
                
                DispatchQueue.main.async {
                    self.change(imageView: imageView, label: label, to: newDataPair, side: .right)
                }
            })
            dataTask.resume()
        } else {
            backCounter -= 1
            change(imageView: imageView, label: label, to: userCashedData[userCashedData.count - 1 - backCounter], side: .right)
        }
    }
    
    func getPreviousImage(to imageView: UIImageView, with label: UILabel) -> Bool {
        backCounter += 1
        if backCounter != userCashedData.count {
            change(imageView: imageView, label: label, to: userCashedData[userCashedData.count - 1 - backCounter], side: .left)
            
            if backCounter + 1 != userCashedData.count {
                return true
            }
        }
        return false
    }
}
