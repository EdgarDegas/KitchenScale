//
//  ScaleView.swift
//  KitchenScale
//
//  Created by 孙一萌 on 2017/4/5.
//  Copyright © 2017年 iMoeNya. All rights reserved.
//

import UIKit

class ScaleView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        isMultipleTouchEnabled = true
        
        let ovalRadius : CGFloat = bounds.width * 2 / 3
        let squareOrigin = CGPoint(x: bounds.midX - ovalRadius/2, y: bounds.midY - ovalRadius/2)
        let square = CGRect(origin: squareOrigin, size: CGSize(width: ovalRadius, height: ovalRadius))
        
        let path = UIBezierPath(ovalIn: square)
        let dashes: [ CGFloat ] = [ 1.5, 2.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        
        UIColor.black.setStroke()
        path.stroke()
    }


}
