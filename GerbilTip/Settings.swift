//
//  File.swift
//  GerbilTip
//
//  Created by R-J Lim on 10/1/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import Foundation

class Settings {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var defaultTipPercentageIndex: Int {
        set {
            defaults.setInteger(newValue, forKey: "defaultTipIndex")
            defaults.synchronize()
        }
        get {
            return defaults.integerForKey("defaultTipIndex")
        }
    }
}