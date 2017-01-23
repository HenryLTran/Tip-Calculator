//
//  TipSettingViewController.swift
//  TipCalculator
//
//  Created by Henry on 1/15/17.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit
class TipSettingViewController: UIViewController {
    
    @IBOutlet weak var tipPercent: UISegmentedControl!
    
    @IBAction func indexChanged(sender:UISegmentedControl) {
        let defaults = UserDefaults.standard
        defaults.set(tipPercent.selectedSegmentIndex, forKey: "TipSegment")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        if let tipSegment = defaults.object(forKey: "TipSegment") as? Int {
            tipPercent.selectedSegmentIndex = tipSegment
        }
    }
    
}
