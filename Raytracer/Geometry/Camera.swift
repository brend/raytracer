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
    let yaw: CGFloat
    let pitch: CGFloat
    let roll: CGFloat
    let transformation: Projection
    
    init(position: Vector, yaw: CGFloat, pitch: CGFloat, roll: CGFloat) {
        self.position = position
        self.yaw = yaw
        self.pitch = pitch
        self.roll = roll
        
        transformation = Projection(yaw: yaw, pitch: pitch, roll: roll, x: position.x, y: position.y, z: position.z)
    }
    
    func perspectiveRay(_ i: Int, _ j: Int, size: CGSize) -> Ray {
        let p = Vector(x: CGFloat(i) - size.width * 0.5,
                       y: CGFloat(j) - size.height * 0.5,
                       z: 0)
        let q = p + Vector(x: 0, y: 0, z: -1)
                
        return Ray(p: transformation * p, q: transformation * q)
    }
    
    func perspectiveRay_OLD(_ i: Int, _ j: Int, size: CGSize) -> Ray {
        
        let up = Vector(x: 0, y: -1, z: 0)
        let left = Vector(x: -1, y: 0, z: 0)
        let forward = Vector(x: 0, y: 0, z: -1)
    
        let p = position + (CGFloat(i) - size.width * 0.5) * left + (CGFloat(j) - size.height * 0.5) * up
        let size2 = CGSize(width: 1.1 * size.width, height: 1.1 * size.height)
        let dist2 = CGFloat(100)
        let q = position + dist2 * forward + (CGFloat(i) * (size2.width / size.width) - size2.width * 0.5) * left + (CGFloat(j) * (size2.height / size.height) - size2.height * 0.5) * up
        
        
        return Ray(p: p, q: q)
        }
    
    func move(input keys: Keys) -> Camera {
        var newX = position.x
        var newY = position.y
        var newZ = position.z
        var newYaw = yaw
        var newPitch = pitch
        var newRoll = roll

        let speed = CGFloat(25)

        if keys.contains(.left) {
            newX -= speed
        } else if keys.contains(.right) {
            newX += speed
        }

        if keys.contains(.up) {
            newZ += speed
        } else if keys.contains(.down) {
            newZ -= speed
        }

        if keys.contains(.q) {
            newRoll += 0.1
        } else if keys.contains(.a) {
            newRoll -= 0.1
        }

        return Camera(position: Vector(x: newX, y: newY, z: newZ), yaw: newYaw, pitch: newPitch, roll: newRoll)
    }
}
