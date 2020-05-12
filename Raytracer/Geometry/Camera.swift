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
        let size2 = CGSize(width: 1.1 * size.width, height: 1.1 * size.height)
        let dist2 = CGFloat(100)
        let q = position + dist2 * forward + (CGFloat(i) * (size2.width / size.width) - size2.width * 0.5) * left + (CGFloat(j) * (size2.height / size.height) - size2.height * 0.5) * up
        
        
        return Ray(p: p, q: q)
    }
    
    func move(input keys: Keys) -> Camera {
        var newPosition = position
        var newForward = forward
        var newUp = up
        
        move(input: keys, &newPosition, &newForward, &newUp)
                
        return Camera(position: newPosition, forward: newForward, up: newUp)
    }
    
    func move(input keys: Keys, _ position: inout Vector, _ forward: inout Vector, _ up: inout Vector) {
        let speed = CGFloat(25)

        if keys.contains(.left) {
            position = position - speed * left
            return
        } else if keys.contains(.right) {
            position = position + speed * left
            return
        }
        
        if keys.contains(.up) {
            position = position + speed * forward
            return
        } else if keys.contains(.down) {
            position = position - speed * forward
            return
        }
        
        let angle = CGFloat.pi / 20
        
        if keys.contains(.q) {
            forward = rotate(forward, around: up, angle: angle)
            up = left.cross(forward)
            return
        } else if keys.contains(.a) {
            forward = rotate(forward, around: up, angle: -angle)
            up = left.cross(forward)
            return
        }
        
        if keys.contains(.w) {
            up = rotate(up, around: left, angle: angle)
            forward = up.cross(left)
            return
        } else if keys.contains(.s) {
            up = rotate(up, around: left, angle: -angle)
            forward = up.cross(left)
            return
        }
    }
}
