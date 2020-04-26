//
//  Ray.swift
//  Raytracer
//
//  Created by Philipp Brendel on 19.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct Ray {
    let p: Vector
    let q: Vector
    
    func tryThis(_ t: CGFloat) -> Vector {
        let d = q - p
        
        return p + t * d
    }
}
