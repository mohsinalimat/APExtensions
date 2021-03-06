//
//  UIStackView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 9/20/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit


@available(iOS 9.0, *)
public extension UIStackView {
    /// Removes all arranged subviews
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    /// Replaces arranged subviews with new ones
    func replaceArrangedSubviews(_ views: [UIView]) {
        removeAllArrangedSubviews()
        views.forEach(addArrangedSubview(_:))
    }
}
