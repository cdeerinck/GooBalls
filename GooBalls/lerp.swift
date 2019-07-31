//
//  lerp.swift
//  Space Shooter
//
//  Created by Chuck Deerinck on 7/18/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import CoreGraphics

func lerp(start:CGFloat,end:CGFloat, weight:CGFloat) -> CGFloat {
    return start + ((end - start) * weight)
}
