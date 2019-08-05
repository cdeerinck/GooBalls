//
//  Constants.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

//Physics Categories
let gooCategory:UInt32 = 0x0001
let barCategory:UInt32 = 0x0002
let groundCategory:UInt32 = 0x0004
let thingsCategory:UInt32 = 0x0008

//Contact Masks
let gooContactMask = barCategory & groundCategory
let barContactMask = gooCategory

//Collisions Masks
let gooCollisionMask = groundCategory
let barCollisionMask = groundCategory
let groundCollisionMask = gooCategory & groundCategory

var maxGooSpeed:CGFloat = 200
var kick:CGFloat = 0.01

var maxBarDistance:CGFloat = 100
