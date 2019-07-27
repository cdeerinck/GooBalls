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
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            //if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
        }
    }


}

