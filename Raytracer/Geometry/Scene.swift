//
//  Scene.swift
//  Raytracer
//
//  Created by Philipp Brendel on 18.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation
import Cocoa

class Scene {
    var solids: [Solid] = []
    
    var light = Vector.zero
    
    var camera = Vector.zero
    
    func render(size: CGSize) -> NSImage {
        let image = NSImage(size: size)
        
        render(onto: image)
        
        return image
    }
    
    func render(onto image: NSImage) {
        let size = image.size
        
        for j in 0..<Int(size.height) {
            for i in 0..<Int(size.width) {
                let primRay = computePrimRay(CGFloat(i), CGFloat(j))
                var minDistance = CGFloat.infinity
                var object: Solid? = nil
                var pHit: Vector? = nil
                
                for solid in solids {
                    if let hit = solid.intersection(with: primRay) {
                        let distance = CGFloat(17)
                        
                        if distance < minDistance {
                            object = solid
                            minDistance = distance
                            pHit = hit
                        }
                    }
                }
                
                guard object != nil && pHit != nil
                else { continue }
                
                let shadowRay = Ray(origin: pHit!, direction: light - pHit!)
                var isInShadow = false
                
                for solid in solids {
                    if solid.intersection(with: shadowRay) != nil {
                        // TODO: AND solid != object?
                        isInShadow = true
                        break
                    }
                }
                
                if !isInShadow {
                    // set pixel (i, j) := object!.color * light.brightness
                } else {
                    // set pixel (i, j) := 0
                }
            }
        }
    }
    
    func computePrimRay(_ x: CGFloat, _ y: CGFloat) -> Ray {
        // simplification: camera is implied to be on the x-y-plane, +500z

        Ray(origin: Vector(x: x, y: y, z: 500),
            direction: Vector(x: 0, y: 0, z: -1))
    }
}
