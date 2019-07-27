//
//  GooBar.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

class GooBar {
    var oneEnd:GooBall
    var otherEnd:GooBall
    var node:SKNode = SKNode()

    init (_ oneEnd:GooBall, _ otherEnd:GooBall) {
        self.oneEnd = oneEnd
        self.otherEnd = otherEnd
    }
}
