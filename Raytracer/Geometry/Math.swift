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

struct Matrix {
    let a0, a1, a2,
        b0, b1, b2,
        c0, c1, c2: CGFloat
    
    init(_ a0: CGFloat, _ a1: CGFloat, _ a2: CGFloat, _ b0: CGFloat, _ b1: CGFloat, _ b2: CGFloat, _ c0: CGFloat, _ c1: CGFloat, _ c2: CGFloat) {
        self.a0 = a0
        self.a1 = a1
        self.a2 = a2
        self.b0 = b0
        self.b1 = b1
        self.b2 = b2
        self.c0 = c0
        self.c1 = c1
        self.c2 = c2
    }
    
    static let identity = Matrix(1, 0, 0, 0, 1, 0, 0, 0, 1)
    
    static func *(s: CGFloat, m: Matrix) -> Matrix {
        Matrix(s*m.a0, s*m.a1, s*m.a2, s*m.b0, s*m.b1, s*m.b2, s*m.c0, s*m.c1, s*m.c2)
    }
    
    static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        Matrix(
            lhs.a0 * rhs.a0 + lhs.a1 * rhs.b0 + lhs.a2 * rhs.c0,
            lhs.a0 * rhs.a1 + lhs.a1 * rhs.b1 + lhs.a2 * rhs.c1,
            lhs.a0 * rhs.a2 + lhs.a1 * rhs.b2 + lhs.a2 * rhs.c2,
            
            lhs.b0 * rhs.a0 + lhs.b1 * rhs.b0 + lhs.b2 * rhs.c0,
            lhs.b0 * rhs.a1 + lhs.b1 * rhs.b1 + lhs.b2 * rhs.c1,
            lhs.b0 * rhs.a2 + lhs.b1 * rhs.b2 + lhs.b2 * rhs.c2,
            
            lhs.c0 * rhs.a0 + lhs.c1 * rhs.b0 + lhs.c2 * rhs.c0,
            lhs.c0 * rhs.a1 + lhs.c1 * rhs.b1 + lhs.c2 * rhs.c1,
            lhs.c0 * rhs.a2 + lhs.c1 * rhs.b2 + lhs.c2 * rhs.c2
        )
    }
    
    static func *(m: Matrix, v: Vector) -> Vector {
        Vector(x: m.a0 * v.x + m.a1 * v.y + m.a2 * v.z,
               y: m.b0 * v.x + m.b1 * v.y + m.b2 * v.z,
               z: m.c0 * v.x + m.c1 * v.y + m.c2 * v.z)
    }
    
    static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
        Matrix(
            lhs.a0 + rhs.a0, lhs.a1 + rhs.a1, lhs.a2 + rhs.a2,
            lhs.b0 + rhs.b0, lhs.b1 + rhs.b1, lhs.b2 + rhs.b2,
            lhs.c0 + rhs.c0, lhs.c1 + rhs.c1, lhs.c2 + rhs.c2
        )
    }
}

func rotate(_ v: Vector, around a: Vector, angle: CGFloat) -> Vector {
    let u = a.normalized()
    let w = Matrix(  0, -u.z,  u.y,
                   u.z,    0, -u.x,
                  -u.y,  u.x,    0)
    let i = Matrix.identity
    let rodrigues = i + sin(angle) * w + (2 * sin(angle/2)*sin(angle/2)) * (w * w)
    let r = rodrigues * v
    
    return r
}
