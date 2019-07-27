//
//  Strings.swift
//  GooBalls
//
//  Created by Chuck Deerinck on 7/27/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

//
//  String.swift
//  HyperSight
//
//  Created by Chuck Deerinck on 9/11/18.
//  Copyright © 2018 Chuck Deerinck. All rights reserved.
//

import Foundation

func startsWith (pattern: String, value: String) -> Bool {
    return pattern == "\(value.prefix(pattern.count))"
}

extension String {

    func after(_ offset:Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: offset)...])
    }

    func before(_ offset:Int) -> String {
        return String(self[...self.index(self.endIndex, offsetBy: -offset - 1)])
    }

    func mid(start:Int, length:Int) -> String {
        // With abcde, and given 3,2 return cd
        let startIdx = self.index(self.startIndex, offsetBy: start)
        let endIdx = self.index(self.startIndex, offsetBy: start + length)
        return String(self[startIdx..<endIdx])
    }

    func killWhiteSpace() -> String {
        var str = self
        while str.starts(with: " ") || str.starts(with:"\n") {
            str = str.after(1)
        }
        return str
    }

}
