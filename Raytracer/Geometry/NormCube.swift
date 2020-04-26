//
//  NormCube.swift
//  Raytracer
//
//  Created by Philipp Brendel on 26.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

struct NormCube: Solid {
    func intersections(with ray: Ray) -> [Vector] {
        if abs(ray.p.x) <= 20 && abs(ray.p.y) <= 20 {
            return [Vector(x: ray.p.x, y: ray.p.y, z: 0)]
        } else {
            return []
        }
    }
}
