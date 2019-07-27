//
//  GooBalls.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/26/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

class GooBall {
    var node:SKNode = SKNode()
    var type:GooType = .normal
    var activity:GooActivity = .waiting
    var boundTo:[GooBall] = []
    var bars:[GooBar] = []
    var interestedIn: CGPoint?
    var size:CGFloat = 1.0

    func feed(amount: CGFloat) {
        size += amount
    }
}