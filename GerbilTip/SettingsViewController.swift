//
//  SettingsViewController.swift
//  GerbilTip
//
//  Created by R-J Lim on 10/1/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let gerbilTip = GerbilTip()
    var defaultTipPercentages = [String]()
    
    @IBOutlet weak var defaultTipButton: UIButton!
    @IBOutlet weak var defaultTipPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        for tipPercentage in gerbilTip.tipPercentages {
            defaultTipPercentages.append(percentage(tipPercentage))
        }

        defaultTipPicker.dataSource = self
        defaultTipPicker.delegate = self
        defaultTipPicker.hidden = true
        
        defaultTipPicker.selectRow(gerbilTip.settings.defaultTipPercentageIndex, inComponent: 0, animated: false)
        
        updateDefaultTipButton()
    }
    
    private func percentage(percent: Double) -> String {
        return String(Int(percent * 100)) + "%"
    }
    
    @IBAction func onTap(sender: AnyObject) {
        defaultTipPicker.hidden = true
    }
    
    @IBAction func onDefaultTipTouchUpInside(sender: AnyObject) {
        defaultTipPicker.hidden = false
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaultTipPercentages.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return defaultTipPercentages[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < gerbilTip.tipPercentages.count else {
            defaultTipPicker.hidden = true
            return
        }
        gerbilTip.settings.defaultTipPercentageIndex = row
        updateDefaultTipButton()
    }
    
    private func updateDefaultTipButton() {
        defaultTipButton.setTitle(percentage(gerbilTip.tipPercentages[gerbilTip.settings.defaultTipPercentageIndex]), forState: UIControlState.Normal)
    }
}
