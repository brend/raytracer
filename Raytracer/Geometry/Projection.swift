//
//  Projection.swift
//  Raytracer
//
//  Created by Philipp Brendel on 09.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct Projection {
    let a1, a2, a3, a4,
        b1, b2, b3, b4,
        c1, c2, c3, c4,
        d1, d2, d3, d4: CGFloat
    
    init(yaw: CGFloat = 0, pitch: CGFloat = 0, roll: CGFloat = 0,
         x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) {
        let cos_yaw = cos(yaw)
        let cos_pitch = cos(pitch)
        let cos_roll = cos(roll)
        let sin_yaw = sin(yaw)
        let sin_pitch = sin(pitch)
        let sin_roll = sin(roll)
        
        a1 = cos_yaw * cos_pitch
        a2 = cos_yaw * sin_pitch * sin_roll - sin_yaw * cos_roll
        a3 = cos_yaw * sin_pitch * cos_roll + sin_yaw * sin_roll
        a4 = x
        
        b1 = sin_yaw * cos_pitch
        b2 = sin_yaw * sin_pitch * sin_roll + cos_yaw * cos_roll
        b3 = sin_yaw * sin_pitch * cos_roll - cos_yaw * sin_roll
        b4 = y
        
        c1 = -sin_pitch
        c2 = cos_pitch * sin_roll
        c3 = cos_pitch * cos_roll
        c4 = z
        
//        d1 = 0
//        d2 = 0
//        d3 = -1
//        d4 = 0
        
        d1 = 0
        d2 = 0
        d3 = 0
        d4 = 1
    }
    
    init(translation vector: Vector) {
        self.init(yaw: 0, pitch: 0, roll: 0, x: vector.x, y: vector.y, z: vector.z)
    }
    
    static func *(m: Projection, v: Vector) -> Vector {
        let w = m.d1 * v.x + m.d2 * v.y + m.d3 * v.z + m.d4
        let x = (m.a1 * v.x + m.a2 * v.y + m.a3 * v.z + m.a4) / w
        let y = (m.b1 * v.x + m.b2 * v.y + m.b3 * v.z + m.b4) / w
        let z = (m.c1 * v.x + m.c2 * v.y + m.c3 * v.z + m.c4) / w
        
        return Vector(x: x, y: y, z: z)
    }
}
