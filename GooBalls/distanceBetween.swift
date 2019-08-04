//
//  distanceBetween.swift
//  GooBalls
//
//  Created by Luke Deerinck on 8/3/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

func distanceBetween(_ node1:SKNode, _ node2:SKNode) -> CGFloat {
    return hypot(node1.physicsBody!.node!.position.x - node2.physicsBody!.node!.position.x, node1.physicsBody!.node!.position.y - node2.physicsBody!.node!.position.y)
}
