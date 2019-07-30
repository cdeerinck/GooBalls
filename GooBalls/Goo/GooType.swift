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
        ballColor = .blue
    case .beauty:
        ballColor = #colorLiteral(red: 1, green: 0.6, blue: 0.8902, alpha: 1) /* #ff99e3 */
    case .ugly:
        ballColor = #colorLiteral(red: 0.5176, green: 0.4196, blue: 0.2941, alpha: 1) /* #846b4b */
    case .bomb:
        ballColor = .red
    }
    return (ballColor, eyeColor, pupilColor, eyeBorderColor)

}

func stringToType(_ value:String) -> GooType {
    switch value {
    case "Normal":
        return .normal
    case "Albino":
        return .albino
    case "Ivy":
        return .ivy
    case "Fuse":
        return .fuse
    case "Dark":
        return .dark
    case "Water":
        return .water
    case "Beauty":
        return .beauty
    case "Ugly":
        return .ugly
    case "Bomb":
        return .bomb
    default:
        return .normal
    }
}
