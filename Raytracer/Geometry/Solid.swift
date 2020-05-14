//
//  Solid.swift
//  Raytracer
//
//  Created by Philipp Brendel on 18.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation
import Cocoa

protocol Solid {
    func intersections(with ray: Ray) -> [Vector]
    var color: Color { get }
    var shadowColor: Color { get }
    var id: Int { get }
}

var idCounter = 0

func makeId() -> Int {
    idCounter += 1
    
    return idCounter
}
