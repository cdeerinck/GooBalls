//
//  unitVector.swift
//  GooBalls
//
//  Created by Luke Deerinck on 8/4/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

// calculates the unit vector for the given vector
func unitVector(_ vector:CGVector) -> CGVector {
    let divisor = hypot(vector.dx, vector.dy)
    return CGVector(dx: vector.dx/divisor, dy: vector.dy/divisor)
    
}
