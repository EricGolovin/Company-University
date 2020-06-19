//
//  StarView.swift
//  Animation-HW
//
//  Created by Eric Golovin on 6/19/20.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import UIKit

class StarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    func configure() {
        let emitter = layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: bounds.size.width / 2, y: 0)
        emitter.emitterSize = bounds.size
        emitter.emitterShape = .rectangle
        
        let emitterCell = CAEmitterCell()
        let image = UIImage(systemName: "star")!.withTintColor(.white, renderingMode: .alwaysTemplate).cgImage
        emitterCell.contents = image
        emitterCell.birthRate = 200
        
        emitterCell.lifetime = 3.5
        
        emitterCell.color = UIColor.white.cgColor
        
        emitterCell.velocity = 10
        emitterCell.velocityRange = 350
        
        emitterCell.emissionRange = CGFloat(Double.pi/2)
        emitterCell.yAcceleration = 70
        emitterCell.xAcceleration = 0
        emitterCell.scale = 0.33
        
        emitterCell.scaleRange = 1.25
        emitterCell.scaleSpeed = -0.25
        emitterCell.alphaRange = 0.2
        emitterCell.alphaSpeed = -0.15
        
        emitter.emitterCells = [emitterCell]
    }
    
}
