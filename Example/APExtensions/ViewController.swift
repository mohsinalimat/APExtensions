//
//  ViewController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 07/11/2017.
//  Copyright (c) 2017 Anton Plebanovich. All rights reserved.
//

import UIKit
import APExtensions


class ViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!

    //-----------------------------------------------------------------------------
    // MARK: - UIViewController Overrides
    //-----------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get all classes that conform to SetupOnce protocol
        let setupOnces: [SetupOnce.Type] = g_getClassesConformToProtocol(SetupOnce.self)
        print("Classes conform to SetupOnce: \(setupOnces)")
        
        print(Date().previousWorkDay)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}
