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
    var leftEye:SKShapeNode = SKShapeNode()
    var lefltPupil:SKShapeNode = SKShapeNode()
    var rightEye:SKShapeNode = SKShapeNode()
    var rightPupil:SKShapeNode = SKShapeNode()
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

    init (scene: SKScene, at:CGPoint, type:GooType = .normal) {
        
        func eyeSize() -> CGFloat {
            return CGFloat.random(in: 0.2...0.3)
        }
        
        func makeEye(parentNode:SKNode, name:String, eyeColor:UIColor, eyeBorderColor:UIColor, pupilColor:UIColor){
            let eye = SKShapeNode(circleOfRadius: eyeSize())
            eye.name = name
            eye.position = CGPoint(x: (name == "RightEye" ? 1:-1)*0.7, y: 0.7)
            eye.fillColor=eyeColor
            eye.strokeColor=eyeBorderColor
            let pupil = SKShapeNode(circleOfRadius: 0.1)
            pupil.position = CGPoint(x: 0, y: (eye.path?.boundingBox.width)!/4)
            pupil.fillColor = pupilColor
            eye.addChild(pupil)
            self.node.addChild(eye)
        }
        
        let gooColors = gooColor(type: type)
        let shapeNode = SKShapeNode(circleOfRadius: 1)
        shapeNode.name = "Goo"
        shapeNode.position = at
        shapeNode.fillColor = gooColors.ballColor
        shapeNode.physicsBody = SKPhysicsBody(circleOfRadius: 1.0)
        shapeNode.physicsBody?.affectedByGravity = true
        self.node = shapeNode
        self.type = type
        makeEye(parentNode: node, name: "RightEye", eyeColor: gooColors.eyeColor, eyeBorderColor: gooColors.eyeBorderColor, pupilColor: gooColors.pupilColor)
        makeEye(parentNode: node, name: "LeftEye", eyeColor: gooColors.eyeColor, eyeBorderColor: gooColors.eyeBorderColor, pupilColor: gooColors.pupilColor)
        scene.addChild(self.node)
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
