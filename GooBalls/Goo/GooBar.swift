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
//        // The old way
//        barPath.move(to: CGPoint(x: -length/2, y: 0))
//        barPath.addLine(to: CGPoint(x: length/2, y: 0))
//        let sprite = SKShapeNode(path: barPath, centered: true)

        // The new way
        // P1
        barPath.move(to: CGPoint(x: -length/2, y: -oneEnd.gooSize))
        // Curve 1 to 2
        barPath.addCurve(to: CGPoint(x: -length/2 - oneEnd.gooSize, y:0), control1: CGPoint(x: -length/2 - oneEnd.gooSize/2, y: -oneEnd.gooSize), control2: CGPoint(x: -length/2 - oneEnd.gooSize, y: -oneEnd.gooSize/2))
        // Curve 2 to 3
        barPath.addCurve(to: CGPoint(x: -length/2, y:oneEnd.gooSize), control1: CGPoint(x: -length/2-oneEnd.gooSize, y: oneEnd.gooSize/2), control2: CGPoint(x: -length/2 - oneEnd.gooSize/2, y: oneEnd.gooSize))
        // Curve 3 to 4
        barPath.addCurve(to: CGPoint(x: 0, y:(oneEnd.gooSize+otherEnd.gooSize)/6), control1: CGPoint(x: -length/2+oneEnd.gooSize/2, y: oneEnd.gooSize), control2: CGPoint(x: -length/6, y: (oneEnd.gooSize+otherEnd.gooSize)/6))
        // Curve 4 to 5
        barPath.addCurve(to: CGPoint(x: length/2, y:otherEnd.gooSize), control1: CGPoint(x: length/6, y: (oneEnd.gooSize+otherEnd.gooSize)/6), control2: CGPoint(x: length/2-otherEnd.gooSize/2, y: otherEnd.gooSize))
        // Curve 5 to 6
        barPath.addCurve(to: CGPoint(x: length/2+otherEnd.gooSize, y:0), control1: CGPoint(x: length/2+otherEnd.gooSize/2, y: otherEnd.gooSize), control2: CGPoint(x: length/2+otherEnd.gooSize, y: otherEnd.gooSize/2))
        // Curve 6 to 7
        barPath.addCurve(to: CGPoint(x: length/2, y:-otherEnd.gooSize), control1: CGPoint(x: length/2+otherEnd.gooSize, y: -otherEnd.gooSize/2), control2: CGPoint(x: length/2+otherEnd.gooSize/2, y: -otherEnd.gooSize))
        // Curve 7 to 8
        barPath.addCurve(to: CGPoint(x: 0, y:-(oneEnd.gooSize+otherEnd.gooSize)/6), control1: CGPoint(x: length/2-otherEnd.gooSize, y: -otherEnd.gooSize), control2: CGPoint(x: length/6, y: -(oneEnd.gooSize+otherEnd.gooSize)/6))
        // Curve 8 to 1
        barPath.addCurve(to: CGPoint(x: -length/2, y: -oneEnd.gooSize), control1: CGPoint(x: -length/6, y: -(oneEnd.gooSize+otherEnd.gooSize)/6), control2: CGPoint(x: -length/2+oneEnd.gooSize/2, y: -oneEnd.gooSize))

        let sprite = SKShapeNode(path: barPath)
        self.addChild(sprite)
        sprite.strokeColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        sprite.fillColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        //self.physicsBody = SKPhysicsBody(polygonFrom: barPath)
        sprite.isUserInteractionEnabled = false
        self.isUserInteractionEnabled = false
        self.name = "Bar"
        scene.addChild(self)
        let barJoint = SKPhysicsJointSpring.joint(withBodyA:oneEnd.physicsBody!, bodyB:otherEnd.physicsBody!, anchorA: oneEnd.position, anchorB: otherEnd.position)
        barJoint.damping = 0.01
        barJoint.frequency = 7.0
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
