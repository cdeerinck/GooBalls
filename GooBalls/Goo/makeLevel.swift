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
    
}
