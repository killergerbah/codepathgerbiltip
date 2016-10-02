//
//  ViewController.swift
//  GerbilTip
//
//  Created by R-J Lim on 9/26/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import UIKit

class ViewController: GerbilTipUIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSideLabel: UILabel!
    @IBOutlet weak var totalSideLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var tipDisplayBar: UIProgressView!
    
    private let gerbilTip = GerbilTip()

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
    }
    
    override func applyColorScheme(colorScheme: ColorScheme) {
        let textColor = colorScheme.textColor
        
        billTextField.textColor = textColor
        totalLabel.textColor = textColor
        tipLabel.textColor = textColor
        tipSideLabel.textColor = textColor
        billLabel.textColor = textColor
        totalSideLabel.textColor = textColor
        
        separatorView.backgroundColor = textColor
        self.view.backgroundColor = gerbilTip.settings.colorScheme.bgColor
        
        tipSegmentedControl.tintColor = gerbilTip.settings.colorScheme.buttonColor
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (gerbilTip.selectedTipPercentageIndex < tipSegmentedControl.numberOfSegments) {
            tipSegmentedControl.selectedSegmentIndex = gerbilTip.selectedTipPercentageIndex
        }
        
        gerbilTip.tipPercentage = tipPercentage()
        updateAll()
        billTextField.clearsOnInsertion = true
        billTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        gerbilTip.onExit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onBillEditingChanged(sender: AnyObject) {
        guard let bill = Double(billTextField.text!) else {
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
        let percent = tipPercentage()
        gerbilTip.tipPercentage = percent
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
        
        self.tipDisplayBar.setProgress(Float(1.0 / (1.0 + gerbilTip.tipPercentage)), animated: true)
    }
    
    private func localizeCurrency(amount:Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(amount)!
    }
}

