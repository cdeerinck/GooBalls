//
//  FindParentGoo.swift
//  GooBalls
//
//  Created by Luke Deerinck on 7/30/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

func findParentGoo(_ node:SKNode) -> SKNode {
    var goo:SKNode = node
    while goo.parent != nil && goo.name != "Goo" {
        goo = goo.parent!
    }
    return goo
}
