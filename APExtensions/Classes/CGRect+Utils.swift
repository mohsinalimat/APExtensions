//
//  CGRect+Utils.swift
//  Anton Plebanovich
//
//  Created by Anton Plebanovich on 5/25/17.
//  Copyright © 2017 Anton Plebanovich. All rights reserved.
//

import UIKit


public extension CGRect {
    public var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin.x = newValue.x - width / 2
            origin.y = newValue.y - height / 2
        }
    }
}
