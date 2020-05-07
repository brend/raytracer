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
    var camera = Camera(position: Vector(x: 0, y: 0, z: 500),
                         forward: Vector(x: 0, y: 0, z: -1),
                              up: Vector(x: 0, y: -1, z: 0))
    var interlaced = false
    
    func renderRows(from start: Int, to finish: Int, on canvas: Canvas) {
        for j in start..<finish {
            if interlaced && j.isMultiple(of: 2) {
                continue
            }
            
            for i in 0..<Int(canvas.size.width) {
                if interlaced && i.isMultiple(of: 2) {
                    continue
                }
                
                renderPixel(i, j, on: canvas)
            }
        }
    }
    
    func render(on canvas: Canvas) {
        let queue = DispatchQueue(label: "raytracer.worker", attributes: .concurrent)
        let group = DispatchGroup()
        let rowCount = Int(canvas.size.height)
        let taskCount = 8
        let rowsPerTask = rowCount / taskCount
        
        for task in 0..<taskCount {
            queue.async(group: group) {
                self.renderRows(from: task * rowsPerTask, to: (task+1) * rowsPerTask, on: canvas)
            }
        }
        
        group.wait()
    }
    
    func renderPixel(_ i: Int, _ j: Int, on canvas: Canvas) {
        guard let (object, pHit) = objectHit(i, j, canvas.size) else { return }
            
        let isInShadow = pixelShadowed(object: object, pHit: pHit)
        let pixelColor = isInShadow ? object.shadowColor : object.color
                
        canvas.fillPixel(i, j, color: pixelColor)
    }
    
    func pixelShadowed(object: Solid, pHit: Vector) -> Bool {
        let shadowRay = Ray(p: pHit, q: light - pHit)
        let distanceToLight = pHit.distance(to: light)

        for solid in solids {
            var intersections = solid.intersections(with: shadowRay)
            
            // only intersections that are closer to the light source than pHit can throw shadow on pHit
            intersections = intersections.filter {
                $0.distance(to: light) < distanceToLight
                    && $0.distance(to: pHit) > 0.5
            }
            
            if !intersections.isEmpty {
                return true
            }
        }
        
        return false
    }
    
    func objectHit(_ i: Int, _ j: Int, _ size: CGSize) -> (Solid, Vector)? {
        let primRay = camera.perspectiveRay(i, j, size: size)
        var minDistance = CGFloat.infinity
        var object: Solid? = nil
        var pHit: Vector? = nil
        
        for solid in solids {
            let intersections = solid.intersections(with: primRay)
            
            if intersections.isEmpty {
                continue
            }
                        
            let hit = intersections.min(by: {primRay.p.distance(to: $0) < primRay.p.distance(to: $1)})!

            let distance = primRay.p.distance(to: hit)
            
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
}
