//
//  ScaleViewController.swift
//  KitchenScale
//
//  Created by 孙一萌 on 2017/4/5.
//  Copyright © 2017年 iMoeNya. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController, ScaleReadable {
    
    @IBOutlet weak var weightLabel: UILabel!
    var scaleReading: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            if traitCollection.forceTouchCapability == .available {
                if touch.force >= touch.maximumPossibleForce {
                    view.backgroundColor = UIColor.red
                } else {
                    view.backgroundColor = UIColor.white
                }
                let force = touch.force / touch.maximumPossibleForce
                scaleReading = force * 385
                weightLabel.text = String(format: "%.4f", scaleReading - (parent as! MasterViewController).trayWeight)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for _ in touches {
            if traitCollection.forceTouchCapability == .available {
                weightLabel.text = String(format: "%.4f", scaleReading - (parent as! MasterViewController).trayWeight)
            }
        }
    }
    
}
