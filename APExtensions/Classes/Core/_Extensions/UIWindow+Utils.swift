//
//  UIWindow+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/9/18.
//  Copyright © 2018 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension UIWindow {
    /// Creates new alert window with AppearanceCaptureViewController as rootViewController
    public static func createAlert() -> UIWindow {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.rootViewController = AppearanceCaptureViewController()
        
        return alertWindow
    }
}