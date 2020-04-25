//
//  Vector.swift
//  Raytracer
//
//  Created by Philipp Brendel on 18.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct Vector {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
    
    static let zero = Vector(x: 0, y: 0, z: 0)
    
    static func -(u: Vector, v: Vector) -> Vector {
        Vector(x: u.x - v.x,
               y: u.y - v.y,
               z: u.z - v.z)
    }
    
    static func +(u: Vector, v: Vector) -> Vector {
        Vector(x: u.x + v.x,
               y: u.y + v.y,
               z: u.z + v.z)
    }
}
