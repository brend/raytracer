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
        
    func render(size: CGSize) -> NSImage {
        let image = NSImage(size: size)

        image.lockFocus()
        NSColor.black.setFill()
        NSBezierPath(rect: .init(origin: .zero, size: size)).fill()
        
        render(onto: image)
        
        image.unlockFocus()
        
        return image
    }
    
    func render(onto image: NSImage) {
        let size = image.size
        
        for j in 0..<Int(size.height) {
            for i in 0..<Int(size.width) {
                guard let (object, pHit) = objectHit(i, j)
                    else { continue }
                
                var isInShadow = false
//                let shadowRay = Ray(p: pHit, q: light - pHit)
//
//                for solid in solids {
//                    if !solid.intersections(with: shadowRay).isEmpty {
//                        // TODO: AND solid != object?
//                        isInShadow = true
//                        break
//                    }
//                }
                
                if !isInShadow {
                    // set pixel (i, j) := object!.color * light.brightness
                    object.color.setFill()
                } else {
                    // set pixel (i, j) := 0
                    NSColor.black.setFill()
                }
                
                NSBezierPath(rect: .init(x: CGFloat(i), y: CGFloat(j), width: 1, height: 1))
                .fill()
            }
        }
    }
    
    func objectHit(_ i: Int, _ j: Int) -> (Solid, Vector)? {
        let primRay = computePrimRay(CGFloat(i), CGFloat(j))
        var minDistance = CGFloat.infinity
        var object: Solid? = nil
        var pHit: Vector? = nil
        
        for solid in solids {
            let intersections = solid.intersections(with: primRay)
            
            if intersections.isEmpty {
                continue
            }
            
            // TODO: Pick intersection closest to camera
            let hit = intersections.first!
            // TODO Distanz von der Kamera einsetzen
            let distance = Vector(x: CGFloat(i), y: CGFloat(j), z: 500).distance(to: hit)
            
            if distance < minDistance {
                object = solid
                minDistance = distance
                pHit = hit
            }
        }
        
        if let resultObject = object,
            let resultPHit = pHit {
            return (resultObject, resultPHit)
        } else {
            return nil
        }
    }
    
    func computePrimRay(_ x: CGFloat, _ y: CGFloat) -> Ray {
        // simplification: camera is implied to be on the x-y-plane, +500z
        Ray(p: Vector(x: x - 200, y: y - 200, z: 500),
            q: Vector(x: x - 200, y: y - 200, z: 499))
    }
}
