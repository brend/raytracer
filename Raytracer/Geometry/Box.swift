//
//  Box.swift
//  Raytracer
//
//  Created by Philipp Brendel on 14.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct Box: Solid {
    
    init(edgeLength: CGFloat, color: Color = .red, shadowColor: Color = .darkRed) {
        self.id = makeId()
        self.color = color
        self.shadowColor = shadowColor
        let e = edgeLength / 2
        triangles = [
            Triangle(Vector(x: -e, y: -e, z: -e),
                     Vector(x:  e, y: -e, z: -e),
                     Vector(x: -e, y:  e, z: -e)),
            Triangle(Vector(x:  e, y: -e, z: -e),
                     Vector(x:  e, y:  e, z: -e),
                     Vector(x: -e, y:  e, z: -e)),
            
            Triangle(Vector(x: e, y: -e, z: -e),
                     Vector(x: e, y: -e, z: e),
                     Vector(x: e, y: e, z: -e), color: .blue, shadowColor: .darkBlue),
            Triangle(Vector(x: e, y: -e, z: e),
                     Vector(x: e, y: e, z: e),
                     Vector(x: e, y: e, z: -e), color: .blue, shadowColor: .darkBlue),
            
//            Triangle(Vector(x: e, y: -e, z: e),
//                     Vector(x: -e, y: -e, z: e),
//                     Vector(x: e, y: e, z: e), color: .yellow, shadowColor: .darkYellow),
//            Triangle(Vector(x: -e, y: -e, z: e),
//                     Vector(x: -e, y: e, z: e),
//                     Vector(x: e, y: e, z: e), color: .yellow, shadowColor: .darkYellow),
//
            Triangle(Vector(x: -e, y: -e, z: -e),
                     Vector(x: -e, y: -e, z: e),
                     Vector(x: -e, y: e, z: -e)),
            Triangle(Vector(x: -e, y: -e, z: e),
                     Vector(x: -e, y: e, z: e),
                     Vector(x: -e, y: e, z: -e))
        ]
    }
    
    let triangles: [Triangle]
    
    func intersections(with ray: Ray) -> [Vector] {
        var pHit: Vector? = nil
        var minDistance = CGFloat.infinity
        
        for t in triangles {
            let points = t.intersections(with: ray)
            
            for p in points {
                let distance = p.distance(to: ray.p)
                
                if distance < minDistance {
                    pHit = p
                    minDistance = distance
                }
            }
        }
        
        if let pHit = pHit {
            return [pHit]
        } else {
            return []
        }
    }
    
    var color: Color
    
    var shadowColor: Color
    
    var id: Int
    
    
}
