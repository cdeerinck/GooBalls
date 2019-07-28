//
//  GooBalls.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/26/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

class GooBall:SKNode {
    //var node:SKNode = SKNode()
    var type:GooType = .normal
    var activity:GooActivity = .waiting
    var boundTo:[GooBall] = []
    var bars:[GooBar] = []
    var interestedIn: CGPoint?
    var gooSize:CGFloat = 1.0

    init? (in scene:SKScene, at:CGPoint, type:GooType = .normal) {
        super.init()
        let sprite = SKSpriteNode(imageNamed: "GooBall1") //(fileNamed: "GooBall1")!
        sprite.setScale(0.05)
        self.addChild(sprite)
        self.name = "Goo"
        self.position = at
        self.setScale(1)
        self.physicsBody = SKPhysicsBody(circleOfRadius: 12.0)
        self.physicsBody?.affectedByGravity = true
        self.type = type
        scene.addChild(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func feed(amount: CGFloat) {
        self.gooSize += amount
    }

    func orient () {
        let speed = hypot(self.physicsBody!.velocity.dx, self.physicsBody!.velocity.dy)
        let angle = atan2(self.physicsBody!.velocity.dy, self .physicsBody!.velocity.dx)
        self.zRotation = angle + CGFloat.pi/2  // To make an naturally up oriented goo to face right + angle
        if speed == 0 {
            self.setScale(1)
        } else {
            print(speed,angle)
            self.xScale = max(1,1/speed) //get smaller based on speed.  No smaller than 0.5
            self.yScale = min(1,1/speed) //get longer based on speed.  No bigger than 1.5
        }
        self.physicsBody?.allowsRotation = false
    }
}
