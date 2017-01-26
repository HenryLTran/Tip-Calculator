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
    //var bill: Double?
    var alpha: Double = 1.0
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var currencyLabel: UILabel!
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
        //print("viewDidLoad")
        self.billTextField.delegate = self
        self.billTextField.becomeFirstResponder()
        
        self.billTextField.keyboardType = UIKeyboardType.decimalPad
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.locale = NSLocale.current
        if let currencyS = currencyFormatter.locale.currencySymbol {
            currencyLabel.text = currencyS
        }
        self.navigationController?.navigationBar.tintColor = self.navigationItem.rightBarButtonItem?.tintColor
        
        let defaults = UserDefaults.standard
        if let tipTimestamp = defaults.object(forKey: "SavedTimestamp") as? Date {
            let currentTimestamp = Date().addingTimeInterval(-600) //10m=600s
            if (currentTimestamp <= tipTimestamp) {
                if let bill = defaults.object(forKey: "SavedBillAmount") as? Double {
                    billTextField.text = "\(bill)"
                }
            } //if (currentDate <= tipTimestamp)
            else {
                billTextField.text = ""
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("viewWillAppear")

        //billTextField.text = ""
        //setting default tip
        let defaults = UserDefaults.standard
        if let tipSegment = defaults.object(forKey: "TipSegment") as? Int
            {
                tipPercent.selectedSegmentIndex = tipSegment
            }
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
            self.secondView.alpha = 0.0
        }, completion: nil)

    } //viewWillAppear
    
    func calculateTip() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
            self.secondView.alpha = 1.00
        }, completion: nil)
        
        if var bill = Double(billTextField.text!) {
            bill = round(bill*100)/100
            billTextField.text = "\(bill)"
            let tip = tipArray[tipPercent.selectedSegmentIndex]
            var tipAmount = (bill * tip)
            tipAmount = round(tipAmount*100)/100
            tipsAmountLabel.text = "\(tipAmount)"
            let totalAmount = bill + tipAmount
            totalAmountLabel.text = currencyFormatter.string(from: totalAmount as NSNumber)
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.savedBill = bill
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
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCrossDissolve, animations: {
            self.secondView.alpha = 0.0
        }, completion: nil)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        calculateTip()
        return true
    }
}

extension String {
    subscript(idx: Int) -> Character {
        guard let strIdx = index(startIndex, offsetBy: idx, limitedBy: endIndex)
            else { fatalError("String index out of bounds") }
        return self[strIdx]
    }
}
