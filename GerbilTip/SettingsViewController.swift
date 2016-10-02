//
//  SettingsViewController.swift
//  GerbilTip
//
//  Created by R-J Lim on 10/1/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import UIKit

class SettingsViewController: GerbilTipUIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var defaultTipButton: UIButton!
    @IBOutlet weak var defaultTipPicker: UIPickerView!
    @IBOutlet weak var colorSchemeLightButton: UIButton!
    @IBOutlet weak var colorSchemeDarkButton: UIButton!
    @IBOutlet weak var colorSchemeSideLabel: UILabel!
    @IBOutlet weak var defaultTipSideLabel: UILabel!
    
    private let gerbilTip = GerbilTip()
    private var defaultTipPercentages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for tipPercentage in gerbilTip.tipPercentages {
            defaultTipPercentages.append(percentage(tipPercentage))
        }

        defaultTipPicker.dataSource = self
        defaultTipPicker.delegate = self
        defaultTipPicker.hidden = true
        
        defaultTipPicker.selectRow(gerbilTip.settings.defaultTipPercentageIndex, inComponent: 0, animated: false)
        
        updateColorSchemeButton()
        updateDefaultTipButton()
    }
    
    override func applyColorScheme(colorScheme: ColorScheme) {
        let textColor = colorScheme.textColor
        
        defaultTipSideLabel.textColor = textColor
        colorSchemeSideLabel.textColor = textColor
        
        view.backgroundColor = colorScheme.bgColor
        defaultTipPicker.reloadAllComponents()
        
        let buttonColor = colorScheme.buttonColor
        defaultTipButton.tintColor = buttonColor
        colorSchemeLightButton.tintColor = buttonColor
        colorSchemeDarkButton.tintColor = buttonColor
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

    @IBAction func onColorSchemeLightTouchUpInside(sender: AnyObject) {
        pickLightColorScheme()
    }
    
    @IBAction func onColorSchemeDarkTouchUpInside(sender: AnyObject) {
        pickDarkColorScheme()
    }
    
    private func pickLightColorScheme() {
        pickColorScheme(ColorScheme.light, enabledButton: colorSchemeLightButton, disabledButton: colorSchemeDarkButton)
    }
    
    private func pickDarkColorScheme() {
        pickColorScheme(ColorScheme.dark, enabledButton: colorSchemeDarkButton, disabledButton: colorSchemeLightButton)
    }
    
    private func pickColorScheme(picked: ColorScheme, enabledButton: UIButton, disabledButton: UIButton) {
        gerbilTip.settings.colorScheme = picked
        toggle(enabledButton, disabled: disabledButton)
        applyColorScheme(picked)
    }

    
    private func toggle(enabled: UIButton, disabled: UIButton) {
        enabled.alpha = 1.0
        disabled.alpha = 0.5
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
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: defaultTipPercentages[row], attributes: [NSForegroundColorAttributeName: gerbilTip.settings.colorScheme.textColor])
    }
    
    private func updateColorSchemeButton() {
        if gerbilTip.settings.colorScheme.id == ColorScheme.dark.id {
            pickDarkColorScheme()
        } else {
            pickLightColorScheme()
        }
    }
    
    private func updateDefaultTipButton() {
        defaultTipButton.setTitle(percentage(gerbilTip.tipPercentages[gerbilTip.settings.defaultTipPercentageIndex]), forState: UIControlState.Normal)
    }
}
