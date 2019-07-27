//
//  GooActivity.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import SpriteKit

enum GooActivity {
    case waiting
    case fixed
    case walkingOn (onNode:SKNode)
    case leaving
    case left
}
