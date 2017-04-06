//
//  MasterViewController.swift
//  KitchenScale
//
//  Created by 孙一萌 on 2017/4/5.
//  Copyright © 2017年 iMoeNya. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    private(set) var trayWeight: CGFloat = 0.0

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private lazy var scaleViewController: ScaleViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScaleViewController") as! ScaleViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var balanceScaleViewController: BalanceScaleViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BalanceScaleViewController") as! BalanceScaleViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        addChildViewController(viewController)
        
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        updateView()
    }
    
    @IBAction func adjustTrayWeight(_ sender: UIBarButtonItem) {
        if let scaleReadable = childViewControllers[0] as? ScaleReadable {
            trayWeight = scaleReadable.scaleReading
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateView()
    }

    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: balanceScaleViewController)
            add(asChildViewController: scaleViewController)
        } else {
            remove(asChildViewController: scaleViewController)
            add(asChildViewController: balanceScaleViewController)
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
