//
//  Sphere.swift
//  Raytracer
//
//  Created by Philipp Brendel on 18.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct Sphere: Solid {
    let center: Vector
    let radius: CGFloat
    
    func intersection(with ray: Ray) -> Vector? {
        // 1. grab the coefficients by putting the ray equation into the sphere equation
        // thus obtaining the coefficients for the quadratic equation a*x*x + b*x + c = 0
        let (a, b, c) = findCoefficients(ray)
        
        // 2. solve the quadratic equation
        let solutions = solveQuadraticEquation(a, b, c)
        
        // 3. put the solutions back into the ray equation
        if solutions.isEmpty {
            return nil
        }
        
        let intersections = solutions.map { ray.tryThis($0) }
        
        // 4. pick the best result, if any
        return closest(in: intersections)!
    }
    
    func findCoefficients(_ ray: Ray) -> (CGFloat, CGFloat, CGFloat) {
        let p = ray.origin
        //let q = ray.origin + ray.direction
        let q = ray.direction - ray.origin
        let dx = q.x - p.x
        let dy = q.y - p.y
        let dz = q.z - p.z
        let dcx = p.x - center.x
        let dcy = p.y - center.y
        let dcz = p.z - center.z
        let a = dx*dx + dy*dy + dz*dz
        let b = 4 * (dx * dcx + dy * dcy + dz * dcz)
        let c = dcx * dcx + dcy * dcy + dcz * dcz - radius * radius
        
        return (a, b, c)
    }
    
    func closest(in points: [Vector]) -> Vector? {
        guard !points.isEmpty else { return nil }
        
        // TODO: Implement -- actually we need the point closest to the camera, don't we?
        
        return points.first!
    }
}
