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
//            let dataTask = URLSession.shared.dataTask(with: URL(string: URLs.animal_720.rawValue)!, completionHandler: { data, response, error in
//                guard let data = data, let image = UIImage(data: data) else {
//                    return
//                }
//
//                let newDataPair = (image: image, title: Name.getRandomName())
//                self.userCashedData.append(newDataPair)
//
//                DispatchQueue.main.async {
//                    self.change(imageView: imageView, label: label, to: newDataPair, side: .right)
//                }
//            })
//            dataTask.resume()
            
            let newTitle = Name.getRandomName()
            
            // TODO: Fix this mess
            let blurEffect = imageView.blurEffectView
            let activityIndicator = imageView.activityIndicator
            
            UIView.transition(with: imageView, duration: 1.0, options: [.transitionFlipFromRight], animations: { // TODO: Fix this options so that blueView and indicator would be private
                imageView.setImageFrom(URLs.animal_720.rawValue, components: (blurEffect, activityIndicator), completion: { image in
                    self.userCashedData.append((image: image, title: newTitle))
                })
            })
            UIView.transition(with: label, duration: 1, options: [.transitionFlipFromTop], animations: {
                label.alpha = 0.0
                label.text = newTitle
            })
            UIView.animateKeyframes(withDuration: 0.3, delay: 0.0, options: [], animations: {
                label.alpha = 1
            }, completion: nil)
            
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

extension UIImageView {
    var blurEffectView: UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .light)
        let visualAffectView = UIVisualEffectView(effect: blurEffect)
        visualAffectView.layer.cornerRadius = layer.cornerRadius
        visualAffectView.frame = bounds
        insertSubview(visualAffectView, at: 0)
        return visualAffectView
    }
    
    var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.gray
        activityIndicator.style = .large
        self.addSubview(activityIndicator)
        
        activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        return activityIndicator
    }
    
    func setImageFrom(_ stringUrl: String, components: (UIVisualEffectView, UIActivityIndicatorView), completion: ((UIImage) -> Void)? = nil) {
        guard let url = URL(string: stringUrl) else {
            return
        }

        DispatchQueue.main.async {
            components.1.startAnimating()
        }
        
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1, animations: {
                    components.0.alpha = 0.0
                    components.1.alpha = 0.0
                    self.image = image
                }, completion: { _ in
                    components.1.stopAnimating()
                    components.0.removeFromSuperview()
                })
                completion?(image)
            }
        })
        dataTask.resume()
        
    }
}
