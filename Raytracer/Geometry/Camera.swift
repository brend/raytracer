//
//  Camera.swift
//  Raytracer
//
//  Created by Philipp Brendel on 07.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation
import Cocoa

struct Camera {
    let position: Vector
    let forward: Vector
    let up: Vector
    
    private let left: Vector
    
    init(position: Vector, forward: Vector, up: Vector) {
        self.position = position
        self.forward = forward
        self.up = up
        self.left = forward.cross(up).normalized()
    }
    
    func perspectiveRay(_ i: Int, _ j: Int, size: CGSize) -> Ray {
        let p = position + (CGFloat(i) - size.width * 0.5) * left + (CGFloat(j) - size.height * 0.5) * up
        let q = p + forward
        
        return Ray(p: p, q: q)
    }
}
