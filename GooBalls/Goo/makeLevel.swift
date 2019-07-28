//
//  makeLevel.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

/*
 LevelSize(x,y)
 Type name[x,y] where Type:= lines,splines
 Goo type[x,y] where type:= normal,albino,ivy,fuse,dark,water,beauty,ugly,bomb
 
 killLeadingWhitespace
 getCommand (Size, Lines, Splites, Goo)
 getName
 getXY
 eatUpToEOL
 */
let level1 = """
Size 1000,500
Lines Box 500,0,500,200,700,200,700,0
Splines Rope 600,200,400,400,400,50
Goo normal,25,25,50,50,75,75,100,100,125,125,150,100,175,75
"""

func makeLevelFrom(in scene:SKScene, _ input:String) {
    
    func getFirstWord(from string:String) -> (String,String) {
        let temp = string.killWhiteSpace()
        let index = temp.firstIndex(of: " ") ?? temp.endIndex
        return (String(temp[..<index]),temp.after(String(temp[..<index]).count+1))
    }
    
    func getNumber(_ from:String) -> (CGFloat,String) {
        let index = lookForFirstNotIn(from, markers:"0123456789+-.")
        let xPos = String(from[..<index!])
        let value = CGFloat(truncating: NumberFormatter().number(from: xPos)!)
        return (value,from.after(xPos.count))
        
    }
    
    func getXY(_ from:String) -> (CGPoint, String) {
        let x:CGFloat
        var string:String
        (x,string) = getNumber(from)
        string = string.after(1)
        let y:CGFloat
        (y,string) = getNumber(string)
        return (CGPoint(x: x, y: y), string)
        
    }
    
    func lookForFirstNotIn(_ value:String, markers: String) -> String.Index? { //"0123456789+-."
        
        for cIndice in value.indices {
            if !markers.contains(value[cIndice]) { return cIndice }
        }
        return nil
    }
    
    var level = input
    while !level.isEmpty {
        level = level.killWhiteSpace()
        let command:String
        (command, level) = getFirstWord(from: level)
        switch command {
        case "Size":
            let point:CGPoint
            (point,level) = getXY(level)
            let rect = CGRect(x: 0, y: 0, width: point.x, height: point.y)
            let shape = SKNode()
            shape.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
            shape.name = "Frame"
            scene.addChild(shape)
        case "Splines":
            var splinePoint:CGPoint
            var points:[CGPoint] = []
            let splineName:String
            (splineName,level) = getFirstWord(from: level)
            repeat {
                if startsWith(pattern: ",", value: level) {
                    level = level.after(1)
                }
                (splinePoint,level) = getXY(level)
                points.append(splinePoint)
            } while startsWith(pattern: ",", value: level)
            let spline = SKShapeNode(splinePoints: &points, count: points.count)
            spline.physicsBody = SKPhysicsBody(edgeChainFrom: spline.path!)
            spline.name = splineName
            scene.addChild(spline)
            
        case "Lines":
            var points:[CGPoint] = []
            var lineName:String
            var point:CGPoint
            repeat {
                if startsWith(pattern: ",", value: level) {
                    level = level.after(1)
                }
                (lineName,level) = getFirstWord(from: level)
                (point,level) = getXY(level)
                points.append(point)
            } while startsWith(pattern: ",", value: level)
            let path = CGMutablePath()
            path.addLines(between: points)
            let node = SKNode()
            node.name = lineName
            node.physicsBody = SKPhysicsBody(edgeChainFrom: path)
            scene.addChild(node)
        case "Goo":
            var points:[CGPoint] = []
            var gooName:String
            var point:CGPoint
            repeat {
                if startsWith(pattern: ",", value: level) {
                    level = level.after(1)
                }
                (gooName,level) = getFirstWord(from: level)
                (point,level) = getXY(level)
                points.append(point)
            } while startsWith(pattern: ",", value: level)
            for point in points {
                let goo = GooBall(in: scene, at: point)
                goo?.node.name = gooName
            }
        default:
            let eol = level.firstIndex(of: "\n") ?? level.endIndex
            level = String(level[..<eol])
        }
    }
}




