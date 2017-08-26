//
//  HouseholdHelperTests.swift
//  HouseholdHelperTests
//
//  Created by Robin on 12/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import XCTest
@testable import HouseholdHelper

class HouseholdHelperTests: XCTestCase {
    

    func testFunc_isInteger() {
        
        XCTAssertTrue(Helper.isInteger(nbr: (2.0)))
        XCTAssertFalse(Helper.isInteger(nbr: (2.5)))
        
    }
    
    
    
    
}
