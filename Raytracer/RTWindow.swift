//
//  RTWindow.swift
//  Raytracer
//
//  Created by Philipp Brendel on 08.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation
import Cocoa

struct Keys: OptionSet {
    let rawValue: UInt16
    
    static let left     = Keys(rawValue: 0b0000_0000_0001)
    static let right    = Keys(rawValue: 0b0000_0000_0010)
    static let up       = Keys(rawValue: 0b0000_0000_0100)
    static let down     = Keys(rawValue: 0b0000_0000_1000)
    
    static let q        = Keys(rawValue: 0b0000_0001_0000)
    static let a        = Keys(rawValue: 0b0000_0010_0000)
    
    static let w        = Keys(rawValue: 0b0000_0100_0000)
    static let s        = Keys(rawValue: 0b0000_1000_0000)
    
    static let e        = Keys(rawValue: 0b0001_0000_0000)
    static let d        = Keys(rawValue: 0b0010_0000_0000)
    
    static let r        = Keys(rawValue: 0b0100_0000_0000)
    static let f        = Keys(rawValue: 0b1000_0000_0000)
    
    static func keyCode(_ keyCode: UInt16) -> Keys {
        switch keyCode {
        case 126:
            return .up
        case 125:
            return .down
        case 123:
            return .left
        case 124:
            return .right
        case 12:
            return .q
        case 0:
            return .a
        case 13:
            return .w
        case 1:
            return .s
        case 2:
            return .d
        case 14:
            return .e
        case 15:
            return .r
        case 3:
            return .f
        default:
            return Keys(rawValue: 0)
        }
    }
}

class RTWindow: NSWindow {
    override func keyDown(with event: NSEvent) {
        guard let delegate = NSApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        delegate.keys = delegate.keys.union(Keys.keyCode(event.keyCode))
    }
    
    override func keyUp(with event: NSEvent) {
        guard let delegate = NSApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        delegate.keys = delegate.keys.subtracting(Keys.keyCode(event.keyCode))
    }
}
