//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by Henry on 1/15/17.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController, UITextFieldDelegate {
    
    var currencyFormatter = NumberFormatter()
    var tipArray: [Double] = [0.10,0.15,0.20]
    var bill: Double?
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipsAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercent: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBAction func indexSegmentChanged (sender:UISegmentedControl) {
        calculateTip()
    }
    
    @IBAction func calculateButton (sender: UIButton) {
        calculateTip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.billTextField.delegate = self
        self.billTextField.becomeFirstResponder()
        self.billTextField.keyboardType = UIKeyboardType.decimalPad
        self.billTextField.keyboardAppearance = UIKeyboardAppearance.dark
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.locale = NSLocale.current
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        self.secondView.alpha = 0.25

        let defaults = UserDefaults.standard
        if let tipTimestamp = defaults.object(forKey: "SavedTimestamp") as? Date {
            let currentTimestamp = Date().addingTimeInterval(-600) //10m=600s
            if (currentTimestamp <= tipTimestamp) {
                if let newBill = defaults.object(forKey: "SavedBillAmount") as? Double {
                billTextField.text = "\(newBill)"

                if let tipSegment = defaults.object(forKey: "SavedTipSegment") as? Int
                {
                    tipPercent.selectedSegmentIndex = tipSegment
                }
 
                calculateTip()
 
                }
            } //if (currentDate <= tipTimestamp)
            else
            {   billTextField.text = ""
                //bill = 0.0
                if let tipSegment = defaults.object(forKey: "TipSegment") as? Int
                {
                    tipPercent.selectedSegmentIndex = tipSegment
                }
            } //else
        }  //if let tipTimestamp
    } //viewWillAppear
    
    func calculateTip() {
        self.secondView.alpha = 1
        if let newBill = Double(billTextField.text!) {
        let tip = tipArray[tipPercent.selectedSegmentIndex]
        var tipAmount = (newBill * tip)
        tipAmount = round(tipAmount*100)/100
        tipsAmountLabel.text = "\(tipAmount)"
        let totalAmount = newBill + tipAmount
        totalAmountLabel.text = currencyFormatter.string(from: totalAmount as NSNumber)
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.savedBill = newBill
        delegate.savedTipSegment = tipPercent.selectedSegmentIndex
        }
    }
    
    // Text Field Delegate Methods
    
    // Tapping on the view should dismiss the keyboard.
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    */
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.secondView.alpha = 0.25
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        calculateTip()
        return true
    }
}
