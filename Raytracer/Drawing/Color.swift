//
//  Color.swift
//  Raytracer
//
//  Created by Philipp Brendel on 01.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation
import Cocoa

struct Color {
    let alpha: UInt8
    let red: UInt8
    let green: UInt8
    let blue: UInt8
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.alpha = 0xFF
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    static let black = Color(red: 0, green: 0, blue: 0)
    static let blue = Color(red: 0x00, green: 0x00, blue: 0xFF)
    static let darkBlue = Color(red: 0x00, green: 0x00, blue: 0x19)
    static let green = Color(red: 0x00, green: 0xFF, blue: 0x00)
    static let darkGreen = Color(red: 0x00, green: 0x19, blue: 0x00)
    static let red = Color(red: 0xFF, green: 0x00, blue: 0x00)
    static let darkRed = Color(red: 0x19, green: 0x00, blue: 0x00)
    static let yellow = Color(red: 0xFF, green: 0xFF, blue: 0x00)
    static let darkYellow = Color(red: 0x19, green: 0x19, blue: 0x00)
}
