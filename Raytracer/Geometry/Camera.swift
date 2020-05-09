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
        self.forward = forward.normalized()
        self.up = up.normalized()
        self.left = forward.cross(up).normalized()
    }
    
    func perspectiveRay(_ i: Int, _ j: Int, size: CGSize) -> Ray {
        let p = position + (CGFloat(i) - size.width * 0.5) * left + (CGFloat(j) - size.height * 0.5) * up
//        let q = p + forward
        
        let size2 = CGSize(width: 1.1 * size.width, height: 1.1 * size.height)
        let dist2 = CGFloat(100)
        let q = position + dist2 * forward + (CGFloat(i) * (size2.width / size.width) - size2.width * 0.5) * left + (CGFloat(j) * (size2.height / size.height) - size2.height * 0.5) * up
        
        
        return Ray(p: p, q: q)
    }
    
    func move(input keys: Keys) -> Camera {
        let speed = CGFloat(25)
        var newPosition = position
        
        if keys.contains(.left) {
            newPosition = position - speed * left
        } else if keys.contains(.right) {
            newPosition = position + speed * left
        }
        
        if keys.contains(.up) {
            newPosition = newPosition + speed * forward
        } else if keys.contains(.down) {
            newPosition = newPosition - speed * forward
        }
        
        var yaw = CGFloat(0)
        
        if keys.contains(.q) {
            yaw += 0.1
        } else if keys.contains(.a) {
            yaw -= 0.1
        }
        
        let m = AffineTransformation(yaw: 0, pitch: 0, roll: yaw)
        let newForward = m * forward
        
        return Camera(position: newPosition, forward: newForward, up: up)
    }
}
