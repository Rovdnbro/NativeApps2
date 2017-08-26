//
//  HelperFunctions.swift
//  HouseholdHelper
//
//  Created by Robin on 25/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import Foundation

class Helper {
    static func isInteger (nbr: Double) -> Bool{
        let isInteger = nbr.truncatingRemainder(dividingBy: 1) == 0
        return isInteger
    }
 
}
