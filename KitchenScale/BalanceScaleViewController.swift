//
//  BalanceScaleViewController.swift
//  KitchenScale
//
//  Created by 孙一萌 on 2017/4/5.
//  Copyright © 2017年 iMoeNya. All rights reserved.
//

import UIKit

// 天平模式，用来称量一定重量的物体
class BalanceScaleViewController: UIViewController, ScaleReadable {
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    
    var scaleReading: CGFloat = 0.0
    
    // 天平模式下的砝码重量
    private var weight:CGFloat = 20.0 {
        didSet {
            weightLabel.text = "-\(weight)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(addDoneButton), name: .UIKeyboardWillShow, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func addDoneButton() {
        let masterViewController = parent as! MasterViewController
        masterViewController.segmentedControl.isUserInteractionEnabled = false
        masterViewController.segmentedControl.isEnabled = false
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(hideKeyboard))
        doneButton.tintColor = UIColor(red: 95.0 / 255.0, green: 94.0 / 255.0, blue: 95.0 / 255.0, alpha: 1.0)
        masterViewController.navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    @objc private func hideKeyboard() {
        let masterViewController = parent as! MasterViewController
        view.endEditing(true)
        masterViewController.navigationItem.rightBarButtonItem = nil
        masterViewController.segmentedControl.isUserInteractionEnabled = true
        masterViewController.segmentedControl.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            if traitCollection.forceTouchCapability == .available {
                let force = touch.force / touch.maximumPossibleForce
                scaleReading = force * 385
                let delta = scaleReading - weight - (parent as! MasterViewController).trayWeight
                weightLabel.text = String(format: "%.4f", delta)
                
                if touch.force >= touch.maximumPossibleForce {
                    view.backgroundColor = UIColor.red
                } else if abs(delta) <= 8.0 {
                    view.backgroundColor = UIColor.green
                } else {
                    view.backgroundColor = UIColor.white
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for _ in touches {
            if traitCollection.forceTouchCapability == .available {
                weightLabel.text = String(format: "%.4f", scaleReading - weight - (parent as! MasterViewController).trayWeight)
            }
        }
    }
    
    @IBAction func weightTextFieldEditingDidEnd(_ sender: UITextField) {
        if sender.text == nil || sender.text!.isEmpty {
            sender.text = "0"
        }
        
        let formatter = NumberFormatter()
        if let weightText = weightTextField.text {
            if let weightNumber = formatter.number(from: weightText) {
                weight = CGFloat(weightNumber.floatValue)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
