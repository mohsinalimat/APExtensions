//
//  Instantiatable.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 6/19/17.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - InstantiatableFromXib

/// Helps to instantiate object from xib file.
public protocol InstantiatableFromXib {
    static func create() -> Self
}

public extension InstantiatableFromXib where Self: NSObject {
    private static func objectFromXib<T>() -> T {
        return UINib(nibName: className, bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
    
    /// Instantiates object from xib file. 
    /// Xib filename should be equal to object class name.
    public static func create() -> Self {
        return objectFromXib()
    }
}

// ******************************* MARK: - InstantiatableFromStoryboard

/// Helps to instantiate object from storyboard file.
public protocol InstantiatableFromStoryboard: class {
    static var storyboardName: String { get }
    static var storyboardID: String { get }
    static func create() -> Self
    static func createWithNavigationController() -> (UINavigationController, Self)
}

public extension InstantiatableFromStoryboard where Self: UIViewController {
    private static func controllerFromStoryboard<T>() -> T {
        let storyboardName = self.storyboardName
        if let initialVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as? T {
            return initialVc
        } else {
            return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: className) as! T
        }
    }
    
    /// Name of storyboard that contains this view controller.
    /// If not specified uses view controller's class name without "ViewController" postfix.
    public static var storyboardName: String {
        return className.replacingOccurrences(of: "ViewController", with: "")
    }
    
    /// View controller storyboard ID.
    /// By default uses view controller's class name.
    public static var storyboardID: String {
        return className
    }
    
    /// Instantiates view controller from storyboard file.
    /// By default uses view controller's class name without "ViewController" postfix for `storyboardName` and view controller's class name for `storyboardID`.
    /// Implement `storyboardName` if you want to secify custom storyboard name.
    /// Implement `storyboardID` if you want to specify custom storyboard ID.
    public static func create() -> Self {
        return controllerFromStoryboard()
    }
    
    /// Instantiates view controller from storyboard file wrapped into navigation controller.
    /// By default uses view controller's class name without "ViewController" postfix for `storyboardName` and view controller's class name for `storyboardID`.
    /// Implement `storyboardName` if you want to secify custom storyboard name.
    /// Implement `storyboardID` if you want to specify custom storyboard ID.
    public static func createWithNavigationController() -> (UINavigationController, Self) {
        let vc = create()
        let navigationVc = UINavigationController(rootViewController: vc)
        
        return (navigationVc, vc)
    }
}

// ******************************* MARK: - InstantiatableContentView

/// Helps to instantiate content view from storyboard file.
public protocol InstantiatableContentView {
    func createContentView() -> UIView
}

public extension InstantiatableContentView where Self: NSObject {
    /// Instantiates contentView from xib file and making instantiator it's owner.
    /// Xib filename should be composed of className + "ContentView" postfix. E.g. MyView -> MyViewContentView
    public func createContentView() -> UIView {
        return UINib(nibName: "\(type(of: self).className)ContentView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
}
