//
//  Canvas.swift
//  Raytracer
//
//  Created by Philipp Brendel on 03.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

protocol Canvas {
    var size: CGSize { get }
    func fillPixel(_ i: Int, _ j: Int, color: Color)
}
