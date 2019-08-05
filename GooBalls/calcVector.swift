//
//  calcVector.swift
//  GooBalls
//
//  Created by Luke Deerinck on 8/4/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

func calcVector(point1:CGPoint, point2:CGPoint) -> CGVector {
    return CGVector(dx: point2.x-point1.x, dy: point2.y-point1.y)
}
