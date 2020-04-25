//
//  Ray.swift
//  Raytracer
//
//  Created by Philipp Brendel on 19.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct Ray {
    let origin: Vector
    let direction: Vector
    
    func tryThis(_ t: CGFloat) -> Vector {
        let p = origin
        let q = direction - origin
        
        return Vector(x: p.x + t * q.x,
                      y: p.y + t * q.y,
                      z: p.z + t * q.z)
    }
}
