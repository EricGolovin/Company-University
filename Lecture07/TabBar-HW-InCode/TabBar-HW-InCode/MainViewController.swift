//
//  ViewController.swift
//  TabBar-HW-InCode
//
//  Created by Eric Golovin on 6/17/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var imageView: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureUI()

    }
    
    func configureUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateImageView))
        imageView.image = UIImage(named: "hello-image")
        
        imageView.layer.cornerRadius = 10
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: -1, height: 5)
        imageView.layer.shadowOpacity = 0.2
        
        
        let halfSafeViewFrameWidth = view.safeAreaLayoutGuide.layoutFrame.width / 2
        imageView.frame = CGRect(x: view.bounds.midX, y: view.frame.midY, width: halfSafeViewFrameWidth, height: halfSafeViewFrameWidth)
        imageView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addGestureRecognizer(tapGesture)
        view.addSubview(imageView)
    }

    @objc func animateImageView() {
        let initialImageViewFrame = imageView.transform
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse], animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            self.imageView.transform = initialImageViewFrame
        })
    }

}

