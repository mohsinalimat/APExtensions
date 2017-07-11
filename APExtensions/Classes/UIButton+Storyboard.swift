//
//  UIButton+Storyboard.swift
//  Anton Plebanovich
//
//  Created by Anton Plebanovich on 22.02.16.
//  Copyright © 2016 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIButton {
    /// Scale button title font for screen
    @IBInspectable var fitSize: Bool {
        get {
            return false
        }
        set {
            guard newValue else { return; }
            
            titleLabel?.font = titleLabel?.font.screenFitFont
        }
    }
}
