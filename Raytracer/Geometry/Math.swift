//
//  Math.swift
//  Raytracer
//
//  Created by Philipp Brendel on 21.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation


func solveQuadraticEquation(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat) -> [CGFloat] {
    let g = b*b - 4*a*c
    
    if g < 0 {
        return []
    }
    
    if g == 0 {
        return [-b / 2 * a]
    }
    
    return [
        (-b + sqrt(g)) / (2 * a),
        (-b - sqrt(g)) / (2 * a)
    ]
}
