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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let view = self.view as! SKView? {
            let scene = GameScene()
            scene.size = view.frame.size //CGSize(width: 100, height: 100)
            //if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.view?.showsFPS = true
            scene.view?.showsNodeCount = true
            scene.view?.showsPhysics = true
            scene.scaleMode = .resizeFill
            scene.setScale(10.0)
let level1 = """
Size 1000,500
Lines Box 500,0,500,200,700,200,700,0
Splines Rope 600,200,400,400,400,50
Goo normal 25,25,50,50,75,75,100,100,125,125,150,100,175,75
"""
            makeLevelFrom(in: scene, level1)
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }


}

