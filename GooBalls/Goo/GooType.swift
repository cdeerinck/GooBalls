//
//  GooType.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

enum GooType {
    case normal
    case albino
    case ivy
    case fuse
    case dark
    case water
    case beauty
    case ugly
    case bomb
}

func gooColor(type:GooType) -> (ballColor:UIColor, eyeColor:UIColor, pupilColor:UIColor, eyeBorderColor:UIColor) {
    var pupilColor:UIColor = .black
    var eyeColor:UIColor = .white
    var ballColor:UIColor = .black
    var eyeBorderColor:UIColor = .black
    switch type {
    case .normal:
        ballColor = .darkGray
    case .albino:
        ballColor = UIColor.white.withAlphaComponent(0.5)
        eyeColor = UIColor.white.withAlphaComponent(0.5)
        pupilColor = UIColor.red.withAlphaComponent(0.5)
        eyeBorderColor = UIColor.white
    case .ivy:
        ballColor = .green
    case .fuse:
        ballColor = .lightGray
    case .dark:
        ballColor = .black
    case .water:
        ballColor = .cyan
        ballColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
    case .beauty:
        ballColor = #colorLiteral(red: 1, green: 0.6, blue: 0.8902, alpha: 1) /* #ff99e3 */
    case .ugly:
        ballColor = #colorLiteral(red: 0.5176, green: 0.4196, blue: 0.2941, alpha: 1) /* #846b4b */
    case .bomb:
        ballColor = .red
    }
    return (ballColor, eyeColor, pupilColor, eyeBorderColor)

}
