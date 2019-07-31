//
//  CGPoint.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/30/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    static func + (lhs:CGPoint, rhs:CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func - (lhs:CGPoint, rhs:CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static prefix func - (lhs:CGPoint) -> CGPoint {
        return CGPoint(x: -lhs.x, y: -lhs.y)
    }

    static func / (lhs:CGPoint, rhs:CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x/rhs, y: lhs.y / rhs)
    }

}
