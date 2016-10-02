//
//  File.swift
//  GerbilTip
//
//  Created by R-J Lim on 10/2/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import Foundation
import UIKit

struct ColorScheme {
    
    static let light: ColorScheme = ColorScheme(
        id: 0,
        textColor: UIColor.blackColor(),
        bgColor: UIColor.whiteColor(),
        buttonColor: UIColor(red:0/255.0, green:122/255.0, blue:255/255.0, alpha:1.0)
    )
    
    static let dark: ColorScheme = ColorScheme(
        id: 1,
        textColor: UIColor.lightTextColor(),
        bgColor: UIColor.darkGrayColor(),
        buttonColor: UIColor(red:0/255.0, green:170/255.0, blue:255/255.0, alpha:1.0)
    )
    
    let id: Int
    let textColor: UIColor
    let bgColor: UIColor
    let buttonColor: UIColor
    
    private init(id: Int, textColor: UIColor, bgColor: UIColor, buttonColor: UIColor) {
        self.id = id
        self.textColor = textColor
        self.bgColor = bgColor
        self.buttonColor = buttonColor
    }
    
    static func get(id: Int) throws -> ColorScheme {
        switch(id) {
            case 0:
                return ColorScheme.light
            case 1:
                return ColorScheme.dark
            default:
                throw ColorSchemeError.DoesNotExist
        }
    }
}

enum ColorSchemeError : ErrorType {
    case DoesNotExist
}