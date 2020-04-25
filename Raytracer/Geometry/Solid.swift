//
//  Solid.swift
//  Raytracer
//
//  Created by Philipp Brendel on 18.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

protocol Solid {
    func intersection(with ray: Ray) -> Vector?
}
