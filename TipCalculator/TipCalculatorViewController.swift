//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by Henry on 1/15/17.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit
var tips: Double = 0.15

class TipCalculatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipsAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercent: UISegmentedControl!
    
    @IBAction func indexSegmentChanged (sender:UISegmentedControl) {
        switch tipPercent.selectedSegmentIndex {
        case 0:     tips = 0.10
        case 2:     tips = 0.20
        default:    tips = 0.15
        }
        calculateTips()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.billTextField.delegate = self
        self.billTextField.becomeFirstResponder()
        self.billTextField.font = UIFont(name: (billTextField.font?.fontName)!, size: 35)
        self.billTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    func calculateTips() {
        let bill = Double(billTextField.text!)
        let tipsAmount = bill! * tips
        tipsAmountLabel.text = "\(tipsAmount.roundTo(places: 2))"
        totalAmountLabel.text = "\((bill!+tipsAmount).roundTo(places: 2))"
        billTextField.text = "\(bill!.roundTo(places: 2))"
        billTextField.font = UIFont(name: (billTextField.font?.fontName)!, size: 35)
    }
    
    // Text Field Delegate Methods
    
    // Tapping on the view should dismiss the keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        tipsAmountLabel.text = "0.00"
        totalAmountLabel.text = "0.00"
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        calculateTips()
        return true
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
