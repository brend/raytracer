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
    var camera = Ray(p: Vector(x: 0, y: 0, z: 500), q: Vector(x: 0, y: 0, z: 499))
        
    func render(size: CGSize) -> NSImage {
        let image = NSImage(size: size)

        render(onto: image)
        
        return image
    }
    
    func render(onto image: NSImage) {
        let size = image.size
        
        image.lockFocus()
        NSColor.black.setFill()
        NSBezierPath(rect: .init(origin: .zero, size: size)).fill()
        
        renderFrame(onto: image)
        
        image.unlockFocus()
    }
    
    func renderFrame(onto image: NSImage) {
        let size = image.size
        
//        for j in 0..<Int(size.height) {
//            for i in 0..<Int(size.width) {
        for j in stride(from: 0, to: Int(size.height), by: 2) {
            for i in stride(from: j.isMultiple(of: 4) ? 0 : 1, to: Int(size.width), by: 2) {
                guard let (object, pHit) = objectHit(i, j, size)
                    else { continue }
                
                var isInShadow = false
                let shadowRay = Ray(p: pHit, q: light - pHit)

                for solid in solids {
                    guard solid.id != object.id else {
                        continue
                    }
                    
                    if !solid.intersections(with: shadowRay).isEmpty {
                        // TODO: AND solid != object?
                        isInShadow = true
                        break
                    }
                }
                
                if !isInShadow {
                    // set pixel (i, j) := object!.color * light.brightness
                    object.color.setFill()
                } else {
                    // set pixel (i, j) := 0
                    object.shadowColor.setFill()
                }
                
                NSBezierPath(rect: .init(x: CGFloat(i), y: CGFloat(j), width: 1, height: 1))
                .fill()
            }
        }
    }
    
    func objectHit(_ i: Int, _ j: Int, _ size: CGSize) -> (Solid, Vector)? {
        let primRay = computePrimRay(CGFloat(i), CGFloat(j), size)
        var minDistance = CGFloat.infinity
        var object: Solid? = nil
        var pHit: Vector? = nil
        
        for solid in solids {
            let intersections = solid.intersections(with: primRay)
            
            if intersections.isEmpty {
                continue
            }
            
            // TODO: use actual camera data
            let camera = Vector(x: 0, y: 0, z: 500)
            
            // TODO: Pick intersection closest to camera
            let hit = intersections.min(by: {camera.distance(to: $0) < camera.distance(to: $1)})!
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
    
    func computePrimRay(_ x: CGFloat, _ y: CGFloat, _ size: CGSize) -> Ray {
        // simplification: camera is implied to be on the x-y-plane, +500z
//        Ray(p: Vector(x: x - size.width / 2, y: y - size.height / 2, z: 500),
//            q: Vector(x: x - size.width / 2, y: y - size.height / 2, z: 499))
        camera - Vector(x: -x + size.width / 2, y: -y + size.height / 2, z: 0)
    }
}
