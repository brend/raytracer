//
//  Vector.swift
//  Raytracer
//
//  Created by Philipp Brendel on 18.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct Vector: Equatable {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
    
    var length: CGFloat {
        sqrt(x*x + y*y + z*z)
    }
        
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
    
    static func *(s: CGFloat, v: Vector) -> Vector {
        Vector(x: s * v.x,
               y: s * v.y,
               z: s * v.z)
    }
    
    func distance(to v: Vector) -> CGFloat {
        let dx = v.x - x
        let dy = v.y - y
        let dz = v.z - z
        
        return sqrt(dx*dx + dy*dy + dz*dz)
    }
    
    func cross(_ b: Vector) -> Vector {
        let a = self
        
        return Vector(x: a.y * b.z - a.z * b.y,
                      y: a.z * b.x - a.x * b.z,
                      z: a.x * b.y - a.y * b.x)
    }
    
    func normalized() -> Vector {
        let length = self.length
        
        return length != 0 ? (1/length) * self : .zero
    }
}
