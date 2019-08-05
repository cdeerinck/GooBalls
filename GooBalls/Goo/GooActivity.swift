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
    case sleeping
    case beingDragged
    case free (pointDestination:CGPoint?, nodeDestination:SKNode?)// Can move around, and effected by gravity.
    case fixed // Part of a structure.  Can be effected by physics, but can't move around.
    case anchored // Used in level set up.  These can't move.
    case walkingOn (onNode:SKNode)
    case leaving
    case left
}

extension GooActivity: Equatable {
    static func ==(lhs: GooActivity, rhs: GooActivity) -> Bool {
        switch (lhs, rhs) {
        case ( .walkingOn, .walkingOn):
            return true
        case (.sleeping,.sleeping),(.free,.free),(.beingDragged,.beingDragged),(.fixed,.fixed),(.anchored,.anchored),(.leaving,.leaving),(.left,.left):
            return true
        default:
            return false
        }
    }
}


