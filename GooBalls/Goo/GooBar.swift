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

class GooBar {
    var oneEnd:GooBall
    var otherEnd:GooBall
    var node:SKShapeNode

    init (scene: SKScene, _ oneEnd:GooBall, _ otherEnd:GooBall) {
        self.oneEnd = oneEnd
        self.otherEnd = otherEnd

        let delta = (otherEnd.position - oneEnd.position)
        let barPath:CGMutablePath = CGMutablePath()
        barPath.move(to: -delta)
        barPath.addLine(to: delta)

        node = SKShapeNode(path: barPath, centered: true)
        node.position = (oneEnd.position + otherEnd.position) / 2
        node.strokeColor = .red
        node.physicsBody = SKPhysicsBody(polygonFrom: barPath)
        let barJoint = SKPhysicsJointSpring.joint(withBodyA:oneEnd.physicsBody!, bodyB:otherEnd.physicsBody!, anchorA: oneEnd.position, anchorB: otherEnd.position)
        scene.physicsWorld.add(barJoint)
    }
}
