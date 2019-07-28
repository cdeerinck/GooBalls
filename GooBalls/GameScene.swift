//
//  GameScene.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene:SKScene, SKPhysicsContactDelegate {

    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        physicsWorld.contactDelegate = self
    }

    func collisionBetween(obj1: SKNode, obj2: SKNode) {
        print("Collision \(obj1.name ?? "") hit \(obj2.name ?? ""))")
    }

    func didBegin(_ contact: SKPhysicsContact) { //checking for contact
        print("Contact \(contact.bodyA.node?.name ?? "") hit \(contact.bodyB.node?.name ?? "") ")
    }

    func touchDown(atPoint pos : CGPoint) {
        //self.anchorPoint = pos
        print(pos)
    }

    func touchMoved(toPoint pos : CGPoint) {
    }

    func touchUp(atPoint pos : CGPoint) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
    }

}
