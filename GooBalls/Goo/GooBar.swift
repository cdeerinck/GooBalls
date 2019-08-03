//
//  GooBar.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics

class GooBar:SKNode {
    var oneEnd:GooBall
    var otherEnd:GooBall
    var length:CGFloat

    init (scene: SKScene, _ oneEnd:GooBall, _ otherEnd:GooBall) {

        self.oneEnd = oneEnd
        self.otherEnd = otherEnd
        oneEnd.activity = .fixed
        otherEnd.activity = .fixed
        let delta = (otherEnd.position - oneEnd.position)
        self.length = hypot(delta.x, delta.y)

        super.init()

        let barPath:CGMutablePath = CGMutablePath()
        barPath.move(to: CGPoint(x: -length/2, y: 0))
        barPath.addLine(to: CGPoint(x: length/2, y: 0))

        let sprite = SKShapeNode(path: barPath, centered: true)
        self.addChild(sprite)
        sprite.strokeColor = .red
        self.physicsBody = SKPhysicsBody(polygonFrom: barPath)
        sprite.isUserInteractionEnabled = false
        self.isUserInteractionEnabled = false
        self.name = "Bar"
        scene.addChild(self)
        let barJoint = SKPhysicsJointSpring.joint(withBodyA:oneEnd.physicsBody!, bodyB:otherEnd.physicsBody!, anchorA: oneEnd.position, anchorB: otherEnd.position)
        scene.physicsWorld.add(barJoint)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func orient() {
        self.position = ((oneEnd.physicsBody?.node?.position)! + (otherEnd.physicsBody?.node?.position)!) / 2
        self.zRotation = atan2((oneEnd.physicsBody?.node?.position.y)! - (otherEnd.physicsBody?.node?.position.y)!, (oneEnd.physicsBody?.node?.position.x)!  - (otherEnd.physicsBody?.node?.position.x)!)
        oneEnd.childNode(withName: "Shape")?.removeAllActions()
        otherEnd.childNode(withName: "Shape")?.removeAllActions()
    }
}
