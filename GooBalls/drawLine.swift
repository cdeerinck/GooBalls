//
//  drawLine.swift
//  GooBalls
//
//  Created by Luke Deerinck on 8/3/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit
func drawLine(scene:GameScene, node1:SKNode, node2:SKNode) -> SKShapeNode {
    let line = SKShapeNode()
    let linePath:CGMutablePath = CGMutablePath()
    linePath.move(to: node1.position)
    linePath.addLine(to: node2.position)
    line.path = linePath
    line.strokeColor = .gray
    line.alpha = 0.5
    scene.addChild(line)
    return line
}
