//
//  ColorableUIViewController.swift
//  GerbilTip
//
//  Created by R-J Lim on 10/2/16.
//  Copyright © 2016 R-J Lim. All rights reserved.
//

import Foundation
import UIKit

class GerbilTipUIViewController : UIViewController, Colorable {
    
    private let gerbilTip = GerbilTip()
    
    override func viewWillAppear(animated: Bool) {
        applyColorScheme(gerbilTip.settings.colorScheme)
    }
    
    func applyColorScheme(colorScheme: ColorScheme) {
    }
}