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

func makeLevelFrom(in scene:SKScene, _ input:String) {
    
    func getFirstWord(from value:String) -> (String,String) {
        let newValue = value.killWhiteSpace()
        let index = newValue.firstIndex(of: " ") ?? newValue.endIndex
        return (String(newValue[..<index]),newValue.after(String(newValue[..<index]).count+1))
    }
    
    func getNumber(_ from:String) -> (CGFloat,String) {
        let index = lookForFirstNotIn(from, markers:"0123456789+-.")
        let stringValue = String(from[..<index!])
        let value = CGFloat(truncating: NumberFormatter().number(from: stringValue)!)
        return (value,from.after(stringValue.count))
        
    }
    
    func getXY(_ value:String) -> (CGPoint, String) {
        let x:CGFloat
        var newValue:String
        (x,newValue) = getNumber(value)
        newValue = newValue.after(1)
        let y:CGFloat
        (y,newValue) = getNumber(newValue)
        return (CGPoint(x: x, y: y), newValue)
        
    }
    
    func lookForFirstNotIn(_ value:String, markers: String) -> String.Index? { //"0123456789+-."
        for cIndice in value.indices {
            if !markers.contains(value[cIndice]) { return cIndice }
        }
        return nil
    }
    
    var level = input + "\n"
    level = level.killWhiteSpace()
    while !level.isEmpty {
        let command:String
        (command, level) = getFirstWord(from: level)
        //print(command)
        switch command {
        case "Size":
            let point:CGPoint
            (point,level) = getXY(level)
            scene.size = CGSize(width: point.x, height: point.y)
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
            spline.strokeColor = .red
            spline.isUserInteractionEnabled = false
            scene.addChild(spline)
            
        case "Lines":
            var points:[CGPoint] = []
            var lineName:String
            var point:CGPoint
            (lineName,level) = getFirstWord(from: level)
            repeat {
                if startsWith(pattern: ",", value: level) {
                    level = level.after(1)
                }
                                (point,level) = getXY(level)
                points.append(point)
            } while startsWith(pattern: ",", value: level)
            let path = CGMutablePath()
            path.addLines(between: points)
            let node = SKShapeNode(path: path)
            node.name = lineName
            node.strokeColor = .green
            node.physicsBody = SKPhysicsBody(edgeChainFrom: path)
            node.isUserInteractionEnabled = false
            scene.addChild(node)
        case "Goo":
            var points:[CGPoint] = []
            var gooTypeName:String
            var point:CGPoint
            (gooTypeName,level) = getFirstWord(from: level)
            let gooType = stringToType(gooTypeName)
            repeat {
                if startsWith(pattern: ",", value: level) {
                    level = level.after(1)
                }
                (point,level) = getXY(level)
                points.append(point)
            } while startsWith(pattern: ",", value: level)
            for point in points {
                let _ = GooBall(scene: scene, at: point, type:gooType)
            }
        case "Bar":
            var point1:CGPoint
            var point2:CGPoint
            var points:[(CGPoint,CGPoint)] = []
            var nodes:[SKNode]
            repeat {
                if startsWith(pattern: ",", value: level) {
                    level = level.after(1)
                }
                (point1,level) = getXY(level)
                if startsWith(pattern: ",", value: level) {
                    level = level.after(1)
                }
                (point2,level) = getXY(level)
                points.append((point1,point2))
            } while startsWith(pattern: ",", value: level)
            for point in points {
                nodes  = scene.nodes(at: point.0)
                let goo1 = findParentGoo(nodes[0]) as! GooBall
                goo1.activity = .anchored
                nodes = scene.nodes(at: point.1)
                let goo2 = findParentGoo(nodes[0]) as! GooBall
                goo2.activity = .anchored
                let _ = GooBar(scene: scene, goo1 , goo2)
            }
        default:
            let eol = level.firstIndex(of: "\n") ?? level.endIndex
            level = String(level[..<eol])
        }
        level = level.killWhiteSpace()
    }
}




