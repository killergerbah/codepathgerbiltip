//
//  ViewController.swift
//  GerbilTip
//
//  Created by R-J Lim on 9/26/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let gerbilTip = GerbilTip()
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 0
        for tipPercentage in gerbilTip.tipPercentages {
            if i == tipSegmentedControl.numberOfSegments {
                break
            }
            
            let percent = Int(tipPercentage * 100.0)
            tipSegmentedControl.setTitle(String(format:"+%d%%", percent), forSegmentAtIndex: i)
            i += 1
        }
        
        gerbilTip.tipPercentage = tipPercentage()
        updateAll()
        billTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (gerbilTip.selectedTipPercentageIndex < tipSegmentedControl.numberOfSegments) {
            tipSegmentedControl.selectedSegmentIndex = gerbilTip.selectedTipPercentageIndex
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBillEditingChanged(sender: AnyObject) {
        guard let bill = Double(billTextField.text!) else {
            print(billTextField.text)
            onBillChanged(0.0)
            return
        }
        
        onBillChanged(bill)
    }
    
    private func onBillChanged(bill: Double) {
        gerbilTip.bill = bill
        updateTip()
    }
    
    @IBAction func onTipSelectedChanged(sender: AnyObject) {
        gerbilTip.tipPercentage = tipPercentage()
        updateTip()
    }

    @IBAction func onBillEditingEnded(sender: AnyObject) {
        updateAll()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    private func tipPercentage() -> Double {
        guard tipSegmentedControl.selectedSegmentIndex < gerbilTip.tipPercentages.count else {
            return gerbilTip.tipPercentages[0]
        }
        
        return gerbilTip.tipPercentages[tipSegmentedControl.selectedSegmentIndex]
    }
    
    private func updateAll() {
        updateBill()
        updateTip()
    }
    
    private func updateBill() {
        billTextField.text = localizeCurrency(gerbilTip.bill)
    }
    
    private func updateTip() {
        totalLabel.text = localizeCurrency(gerbilTip.total)
        tipLabel.text = "+" + localizeCurrency(gerbilTip.tip)
    }
    
    private func localizeCurrency(amount:Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(amount)!
    }
}

