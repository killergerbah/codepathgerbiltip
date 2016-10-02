//
//  GerbilTipModel.swift
//  GerbilTip
//
//  Created by R-J Lim on 9/26/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import Foundation

class GerbilTip {
    
    let tipPercentages = [0.15, 0.20, 0.25]
    let settings = Settings()
    
    private let state = State.instance
    
    var bill: Double {
        get {
            return state.bill
        }
        set {
            state.bill = newValue
        }
    }
    
    var tipPercentage: Double {
        get {
            return state.tipPercentage
        }
        set {
            state.tipPercentage = newValue
        }
    }
    
    
    var total: Double {
        return bill + tip
    }
    
    var tip: Double {
        return tipPercentage * bill
    }
    
    var selectedTipPercentageIndex: Int {
        return settings.defaultTipPercentageIndex
    }
    
    private class State {
        static let instance = State()
        static let userDefaults = NSUserDefaults.standardUserDefaults()
        static let billExpiration = 600.0
        
        var billInternal: Double;
        
        var bill: Double {
            get {
                return billInternal
            }
            set {
                billInternal = newValue
                State.saveDefaultBill(newValue)
            }
        }
        
        var tipPercentage = 0.0
        
        init() {
            billInternal = State.defaultBill()
        }
        
        private class func saveDefaultBill(bill: Double) {
            userDefaults.setDouble(bill, forKey: "bill")
            userDefaults.setDouble(NSDate().timeIntervalSince1970, forKey: "billTimestamp")
        }
        
        private class func defaultBill() -> Double {
            let created = userDefaults.doubleForKey("billTimestamp")
            let now = NSDate().timeIntervalSince1970
            if (now - created < billExpiration) {
                return userDefaults.doubleForKey("bill")
            }
            
            return 0.0
        }
 
    }
}