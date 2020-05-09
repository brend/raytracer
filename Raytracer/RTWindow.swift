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
    
    static let left     = Keys(rawValue: 0b0000_0001)
    static let right    = Keys(rawValue: 0b0000_0010)
    static let up       = Keys(rawValue: 0b0000_0100)
    static let down     = Keys(rawValue: 0b0000_1000)
    
    static let q        = Keys(rawValue: 0b0001_0000)
    static let a        = Keys(rawValue: 0b0010_0000)
    
    static func keyCode(_ keyCode: UInt16) -> Keys {
        switch keyCode {
        case 126:
            return Keys.up
        case 125:
            return Keys.down
        case 123:
            return Keys.left
        case 124:
            return Keys.right
        case 12:
            return Keys.q
        case 0:
            return Keys.a
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
