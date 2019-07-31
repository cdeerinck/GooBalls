//
//  ViewController.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/26/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    let scene = GameScene()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let view = self.view as! SKView? {
            scene.size = view.frame.size //CGSize(width: 100, height: 100)
            print(scene.anchorPoint) //
            scene.anchorPoint = CGPoint(x: 0.1,y: 0.2)
            // Set the scale mode to scale to fit the window
            scene.view?.showsFPS = true
            scene.view?.showsNodeCount = true
            scene.view?.showsPhysics = true

let level1 = """
Size 1000,500
Lines Box 500,0,500,200,700,200,700,0
Lines Right 900,500,800,450,900,400,800,350,900,300,800,250,900,200,800,150,900,100,800,50
Lines Left 800,500,700,450,800,400,700,350,800,300,700,250,800,200,700,150,800,100,700,50
Splines Rope 600,200,400,220,245,170,300,150
Splines Hill 0,350,50,110,100,80,170,140,400,100,800,300
Goo Normal 25,25
Goo Albino 50,50
Goo Ugly 75,75
Goo Water 100,100,125,125,150,100,175,75
Bar 25,25,50,50,125,125,175,75
"""

            // Bar 25,25,50,50,125,125,175,75

            makeLevelFrom(in: scene, level1)
            view.presentScene(scene)
            view.ignoresSiblingOrder = true

            let yay = SKAudioNode(fileNamed: "Yay.mp3")
            scene.addChild(yay)
        }
    }

    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        scene.handlePan(sender)
    }
    @IBAction func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        scene.scaleCamera(sender)
}
}
