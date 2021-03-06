//
//  Constants_isRunningUnitTests_Spec.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/2/19.
//  Copyright © 2019 Anton Plebanovich All rights reserved.
//

import Quick
import Nimble
@testable import APExtensions

// po ProcessInfo.processInfo.environment.forEach { print("\"\($0)\": \"\($1)\",") }
// comm -23 file1 file2 - Different lines from file 1
// comm -13 file1 file2 - Different lines from file 2
class Constants_isRunningUnitTests_Spec: QuickSpec {
    override func spec() {
        describe("Constants.isRunning...") {
            it("should return valid value for Tests") {
                expect(Constants.isRunningTests).to(beTrue())
            }
            
            it("should return valid value for UITests") {
                expect(Constants.isRunningUITests).to(beFalse())
            }
            
            it("should return valid value for UnitTests") {
                expect(Constants.isRunningUnitTests).to(beTrue())
            }
        }
    }
}
