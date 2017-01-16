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
        switch tipPercent.selectedSegmentIndex {
        case 0:     tips = 0.10
        case 2:     tips = 0.20
        default:    tips = 0.15
        }
    }
    
}
