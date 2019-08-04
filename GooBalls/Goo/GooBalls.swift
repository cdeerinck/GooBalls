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
    var leftEye:SKShapeNode = SKShapeNode()
    var lefltPupil:SKShapeNode = SKShapeNode()
    var rightEye:SKShapeNode = SKShapeNode()
    var rightPupil:SKShapeNode = SKShapeNode()
    var type:GooType = .normal
    var isDraggable:Bool {
        get {
            return self.activity == .free || self.activity == .walkingOn(onNode: self) 
        }
    }
    var activity:GooActivity = .free {
        didSet {
            switch self.activity {
            case .free:
                self.isUserInteractionEnabled = true
                self.physicsBody?.affectedByGravity = true
            case .sleeping:
                self.isUserInteractionEnabled = false
                self.physicsBody?.affectedByGravity = true
            case .beingDragged:
                self.isUserInteractionEnabled = true
                self.physicsBody?.affectedByGravity = false
            case .anchored:
                self.isUserInteractionEnabled = false
                self.physicsBody?.affectedByGravity = false
            case .fixed:
                self.isUserInteractionEnabled = false
                self.physicsBody?.affectedByGravity = true
            case .walkingOn:
                self.isUserInteractionEnabled = true
                self.physicsBody?.affectedByGravity = false
            case .leaving:
                self.isUserInteractionEnabled = false
                self.physicsBody?.affectedByGravity = false
            case .left:
                self.isUserInteractionEnabled = false
                self.physicsBody?.affectedByGravity = false
//            default:
//                self.isUserInteractionEnabled = self.isUserInteractionEnabled
            case .anchored:
                self.isUserInteractionEnabled = false
                self.physicsBody?.affectedByGravity = false
            }
        }
    }
    var boundTo:[GooBall] = []
    var bars:[GooBar] = []
    var interestedIn: CGPoint?
    var gooSize:CGFloat = 1.0

    init? (in scene:SKScene, at:CGPoint, type:GooType = .normal) {
        super.init()
        let sprite = SKSpriteNode(imageNamed: "GooBall1") //(fileNamed: "GooBall1")!
        sprite.setScale(0.05)
        sprite.isUserInteractionEnabled = false
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

        let breatheAction: SKAction = {
            let time = Double.random(in: 0.4...0.5)
            let grow = SKAction.scale(to: 0.12, duration: time)
            grow.timingMode = .easeInEaseOut
            let shrink = SKAction.scale(to: 0.10, duration: time)
            shrink.timingMode = .easeInEaseOut
            let sequence = SKAction.sequence([grow, shrink])
            return SKAction.repeatForever(sequence)
        }()
        
        func eyeSize() -> CGFloat {
            return CGFloat.random(in: 20...40)
        }
        
        func makeEye(parentNode:SKNode, name:String, eyeColor:UIColor, eyeBorderColor:UIColor, pupilColor:UIColor){
            let eye = SKShapeNode(circleOfRadius: eyeSize())
            eye.name = name
            eye.position = CGPoint(x: (name == "Right Eye" ? 1:-1)*70, y: 70)
            eye.fillColor=eyeColor
            eye.strokeColor=eyeBorderColor
            eye.isUserInteractionEnabled = false
            let pupil = SKShapeNode(circleOfRadius: 10)
            pupil.position = CGPoint(x: 0, y: (eye.path?.boundingBox.width)!/5)
            pupil.fillColor = pupilColor
            pupil.isUserInteractionEnabled = false
            eye.addChild(pupil)

            parentNode.addChild(eye)
        }
    
        super.init()
        let gooColors = gooColor(type: type)
        let shapeNode = SKShapeNode(circleOfRadius: 100)
        self.name = "Goo"
        self.position = at
        shapeNode.fillColor = gooColors.ballColor
        shapeNode.strokeColor = gooColors.ballColor
        //shapeNode.lineWidth = 0.001
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.friction = 0.03
        shapeNode.setScale(0.1)
        shapeNode.run(breatheAction)
        shapeNode.name = "Shape"
        self.addChild(shapeNode)
        self.type = type
        makeEye(parentNode: shapeNode, name: "Right Eye", eyeColor: gooColors.eyeColor, eyeBorderColor: gooColors.eyeBorderColor, pupilColor: gooColors.pupilColor)
        makeEye(parentNode: shapeNode, name: "Left Eye", eyeColor: gooColors.eyeColor, eyeBorderColor: gooColors.eyeBorderColor, pupilColor: gooColors.pupilColor)
        scene.addChild(self)
    }


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func feed(amount: CGFloat) {
        self.gooSize += amount
    }

    func openEyes(_ open:Bool = true) {
        let sprite = self.children.first
        sprite?.childNode(withName: "Left Eye")?.isHidden = !open
        sprite?.childNode(withName: "Right Eye")?.isHidden = !open
    }

    func orient () {
        let speed = hypot(self.physicsBody!.velocity.dx, self.physicsBody!.velocity.dy)
        if speed > 500 {
            openEyes(false)
        } else {
            if Int.random(in: 0...100) == 0 { openEyes(true) }
            if Int.random(in: 0...100) == 0 { openEyes(false) }
        }
        if speed > 20 {
            let angle = atan2(self.physicsBody!.velocity.dy, self .physicsBody!.velocity.dx)
            self.zRotation = angle - CGFloat.pi/2  // To make an naturally up oriented goo to face right + angle
        }
        if speed == 0 {
            self.setScale(1)
        }
        else {
            self.xScale = max(0.5,1 - (speed/2000)) //get smaller based on speed.  No smaller than 0.5
            self.yScale = min(1.5,1 + (speed/2000)) //get longer based on speed.  No bigger than 1.5
        }
        self.physicsBody?.allowsRotation = false
    }
}
