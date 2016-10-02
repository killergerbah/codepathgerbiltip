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
        
        var bill = 0.0
        
        var tipPercentage = 0.0
 
    }
}