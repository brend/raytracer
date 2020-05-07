//
//  RaytracerImageView.swift
//  Raytracer
//
//  Created by Philipp Brendel on 07.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation
import Cocoa

class RaytracerImageView: NSImageView {
    
    override var acceptsFirstResponder: Bool { true }
    
    override func keyDown(with event: NSEvent) {
        print("Key down: \(event)")
    }
}
