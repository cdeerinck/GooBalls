//
//  GameScene.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene:SKScene, SKPhysicsContactDelegate, SKSceneDelegate {
    
    var selectedGoo:GooBall?
    var tracking = false
    var myCamera:SKCameraNode = SKCameraNode()
    var previousCameraScale = CGFloat()
    var previousGooPosition = CGPoint()
    var previousCameraPoint = CGPoint()
    var tempBars:[SKShapeNode] = []
    let minCameraScale:CGFloat = 0.3
    let maxCameraScale:CGFloat = 5.0
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        scene?.delegate = self
        self.view?.showsFPS = true
        self.view?.showsNodeCount = true
        self.view?.showsPhysics = true
        self.view?.showsFields = true
        self.scaleMode = .aspectFill
        self.camera = myCamera
        self.addChild(myCamera)
    }
    
    
    override func didSimulatePhysics() {
        for gooBall in self.children.filter({$0.name == "Goo"}) as! [GooBall]  {
            gooBall.orient()
        }
        for gooBar in self.children.filter({$0.name == "Bar"}) as! [GooBar]  {
            gooBar.orient()
        }
    }
    
    func collisionBetween(obj1: SKNode, obj2: SKNode) {
        print("Collision \(obj1.name ?? "") hit \(obj2.name ?? ""))")
    }
    
    func didBegin(_ contact: SKPhysicsContact) { //checking for contact
        print("Contact \(contact.bodyA.node?.name ?? "") hit \(contact.bodyB.node?.name ?? "") ")
    }
    
    func touchDown(atPoint pos : CGPoint) {
        //self.anchorPoint = pos
        if let gooAtPos = scene?.atPoint(pos) {
            selectedGoo = findParentGoo(gooAtPos) as? GooBall
        }
        tracking = false
        if selectedGoo?.name != "Goo" {
            print("Touched \(selectedGoo?.name ?? "unknown") at \(pos)")
            selectedGoo = nil
            
        }
        //myCamera.position = pos
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    func scaleCamera(_ sender: UIPinchGestureRecognizer) {
        guard let camera = self.camera else {return}
        if sender.state == .began {
            previousCameraScale = camera.xScale
        }
        let requestedCameraScale = previousCameraScale*1/sender.scale
        // print(previousCameraScale*1/sender.scale)
        
        if requestedCameraScale < maxCameraScale && requestedCameraScale > minCameraScale {
            camera.setScale(requestedCameraScale)
            // print("max:\(maxCameraScale) min:\(minCameraScale) actual:\(requestedCameraScale)" )
        } else {return }
    }
    
    func handlePan(_ sender: UIPanGestureRecognizer) {
        
        guard let camera = self.camera else {return}
        let offset = sender.translation(in: self.view) * (self.frame.width / (sender.view?.frame.width)!)
        switch sender.state {
        case .began:
            //print(sender.location(ofTouch: 0, in: self.view))
            if let gooAtPos = scene?.atPoint(self.convertPoint(fromView: sender.location(in: self.view))) {
                selectedGoo = findParentGoo(gooAtPos) as? GooBall
                if selectedGoo?.name == "Goo" && selectedGoo!.isDraggable {
                    previousGooPosition = (selectedGoo!.physicsBody?.node!.position)!
                    selectedGoo?.activity = .beingDragged
                } else {
                    selectedGoo = nil
                    previousCameraPoint = camera.position
                }
            }
        case .cancelled, .failed:
            if selectedGoo == nil {
                camera.position = previousCameraPoint
            } else {
                selectedGoo?.position = previousGooPosition
            }
        case .changed, .ended:
            if selectedGoo == nil {
                camera.position = CGPoint(x: previousCameraPoint.x + (offset.x * camera.xScale) * -1, y: previousCameraPoint.y + (offset.y * camera.yScale))
            } else {
                //selectedGoo?.position = CGPoint(x: previousGooPosition.x + (offset.x * camera.xScale), y: previousGooPosition.y + (offset.y * camera.yScale) * -1)
                self.removeChildren(in: tempBars)
                tempBars = []
                selectedGoo?.physicsBody?.node?.position.x = previousGooPosition.x + (offset.x * camera.xScale)
                selectedGoo?.physicsBody?.node?.position.y = previousGooPosition.y - (offset.y * camera.yScale)
                let tStaticGoo = (self.children.filter({$0.name == "Goo"}) as! [GooBall]).filter({$0.activity == .fixed || $0.activity == .anchored}).filter({distanceBetween($0, selectedGoo!) <= maxBarDistance}).sorted(by: {distanceBetween($0, selectedGoo!) < distanceBetween($1, selectedGoo!)})
                var staticGoo:[GooBall] = []
                if tStaticGoo.count >= 2 {
                    staticGoo.append(tStaticGoo[0])
                    staticGoo.append(tStaticGoo[1])
                }
                if tStaticGoo.count < 2 {
                    staticGoo = []
                }
                if sender.state == .changed {
                    for goo in staticGoo {
                        tempBars.append(drawLine(scene: self, node1: goo, node2: selectedGoo!))
                    }
                }
                if sender.state == .ended {
                    for goo in staticGoo {
                        let _ = GooBar(scene: self, goo, selectedGoo!)
                    }
                    if staticGoo.count == 0 { selectedGoo?.activity = .free }
                }
            }
        default:
            print("Unhandled pan state:\(sender.state)")
        }
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
        if tracking && selectedGoo != nil {
            myCamera.position = selectedGoo!.position
        }
    }
    
}
