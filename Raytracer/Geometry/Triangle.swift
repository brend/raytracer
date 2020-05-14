//
//  Triangle.swift
//  Raytracer
//
//  Created by Philipp Brendel on 14.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct Triangle: Solid {
    let v0, v1, v2: Vector
    let color: Color
    let shadowColor: Color
    let id: Int
    
    let normal: Vector
    let D: CGFloat
    
    let epsilon = CGFloat(0.01)
    
    init(_ a: Vector, _ b: Vector, _ c: Vector,
         color: Color = .red, shadowColor: Color = .darkRed) {
        self.v0 = a
        self.v1 = b
        self.v2 = c
        
        self.color = color
        self.shadowColor = shadowColor
        self.id = makeId()
        
        normal = (b - a).cross(c - a).normalized()
        D = normal.dot(self.v0)
    }
    
    func intersections(with ray: Ray) -> [Vector] {
        let denominator = normal.dot(ray.q - ray.p)
        
        if abs(denominator) < epsilon {
            return []
        }
        
        let t = -(normal.dot(ray.p) + D) / denominator
        
        if t < 0 {
            return []
        }
        
        let pHit = ray.tryThis(t)
        
        if inside(pHit) {
            return [pHit]
        }
        else {
            return []
        }
    }
    
    func inside(_ pHit: Vector) -> Bool {
        let edge0 = v1 - v0
        let vp0 = pHit - v0
        let c0 = edge0.cross(vp0)
        
        if normal.dot(c0) < 0 {
            return false
        }
        
        let edge1 = v2 - v1
        let vp1 = pHit - v1
        let c1 = edge1.cross(vp1)
        
        if normal.dot(c1) < 0 {
            return false
        }
        
        let edge2 = v0 - v2
        let vp2 = pHit - v2
        let c2 = edge2.cross(vp2)
        
        if normal.dot(c2) < 0 {
            return false
        }
        
        return true
    }
}
