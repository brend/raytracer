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
    var interlaced = false
    
    func render(size: CGSize) -> NSImage {
        let bitmap = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(size.width),
            pixelsHigh: Int(size.height),
            bitsPerSample: 8,
            samplesPerPixel: 3,
            hasAlpha: false,
            isPlanar: false,
            colorSpaceName: .deviceRGB,
            bitmapFormat: .init(),
            bytesPerRow: 3 * Int(size.width),
            bitsPerPixel: 24)!
        let data = bitmap.bitmapData!
        
        render(size: size, buffer: data)
        
        let image = NSImage()
        
        image.addRepresentation(bitmap)
        
        return image
    }
    
    func renderRows(from start: Int, to finish: Int, size: CGSize, buffer: UnsafeMutablePointer<UInt8>, queue: DispatchQueue) {
        for j in start..<finish {
            if interlaced && j.isMultiple(of: 2) {
                continue
            }
            
            for i in 0..<Int(size.width) {
                if interlaced && i.isMultiple(of: 2) {
                    continue
                }
                
                renderPixel(i, j, size: size, buffer: buffer, queue: queue)
            }
        }
    }
    
    func render(size: CGSize, buffer: UnsafeMutablePointer<UInt8>) {
        let queue = DispatchQueue(label: "raytracer.worker", attributes: .concurrent)
        let group = DispatchGroup()
        let rowCount = Int(size.height)
        let taskCount = 8
        let rowsPerTask = rowCount / taskCount
        
        for task in 0..<taskCount {
            queue.async(group: group) {
                self.renderRows(from: task * rowsPerTask, to: (task+1) * rowsPerTask, size: size, buffer: buffer, queue: queue)
            }
        }
        
        group.wait()
    }
    
    func renderPixel(_ i: Int, _ j: Int, size: CGSize, buffer: UnsafeMutablePointer<UInt8>, queue: DispatchQueue) {
        guard let (object, pHit) = objectHit(i, j, size) else { return }
            
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
        
        let pixelColor: Color
        
        if !isInShadow {
            pixelColor = object.color
        } else {
            pixelColor = object.shadowColor
        }
                
        fillPixel(i, j, buffer: buffer, size: size, color: pixelColor)
    }
    
    func fillPixel(_ i: Int, _ j: Int, buffer: UnsafeMutablePointer<UInt8>, size: CGSize, color: Color) {
        let offset = 3 * (j * Int(size.width) + i)
        
        buffer[offset + 0] = color.red
        buffer[offset + 1] = color.green
        buffer[offset + 2] = color.blue
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
                        
            let hit = intersections.min(by: {primRay.p.distance(to: $0) < primRay.p.distance(to: $1)})!
            // TODO Distanz von der Kamera einsetzen
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
    
    func computePrimRay(_ x: CGFloat, _ y: CGFloat, _ size: CGSize) -> Ray {
        // simplification: camera is implied to be on the x-y-plane, +500z
//        Ray(p: Vector(x: x - size.width / 2, y: y - size.height / 2, z: 500),
//            q: Vector(x: x - size.width / 2, y: y - size.height / 2, z: 499))
        camera - Vector(x: -x + size.width / 2, y: -y + size.height / 2, z: 0)
    }
}
