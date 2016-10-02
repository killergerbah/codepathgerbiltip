//
//  File.swift
//  GerbilTip
//
//  Created by R-J Lim on 10/1/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import Foundation

class Settings {
    
    static let instance = Settings()
    private static let defaults = NSUserDefaults.standardUserDefaults()
    private var colorSchemeInternal: ColorScheme
    
    var defaultTipPercentageIndex: Int {
        get {
            return Settings.defaults.integerForKey("defaultTipIndex")
        }
        set {
            Settings.defaults.setInteger(newValue, forKey: "defaultTipIndex")
            Settings.defaults.synchronize()
        }
    }
    
    var colorScheme: ColorScheme {
        get {
            return colorSchemeInternal
        }
        set {
            colorSchemeInternal = newValue
            Settings.defaults.setInteger(newValue.id, forKey: "colorSchemeId")
            Settings.defaults.synchronize()
        }
    }
    
    init() {
        colorSchemeInternal = Settings.colorSchemeSetting()
    }
    
    private class func colorSchemeSetting() -> ColorScheme {
        let id = defaults.integerForKey("colorSchemeId")
        do {
            return try ColorScheme.get(id)
        } catch {
            print("Failed to retrieve color scheme for id=" + String(id))
        }
        
        return ColorScheme.light
    }
}