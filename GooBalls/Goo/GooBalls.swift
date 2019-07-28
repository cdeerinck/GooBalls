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
    var gooSize:CGFloat = 1.0

    init? (in scene:SKScene, at:CGPoint, type:GooType = .normal) {
        node = SKSpriteNode(imageNamed: "GooBall1")    //(fileNamed: "GooBall1")!
        node.name = "GooBall"
        node.position = at
        node.setScale(0.05)
        node.physicsBody = SKPhysicsBody(circleOfRadius: 12.0)
        node.physicsBody?.affectedByGravity = true
        self.type = type
        scene.addChild(node)
    }

    init (scene: SKScene, at:CGPoint, type:GooType = .normal) {
        let gooColors = gooColor(type: type)
    }

    func feed(amount: CGFloat) {
        self.gooSize += amount
    }
}
