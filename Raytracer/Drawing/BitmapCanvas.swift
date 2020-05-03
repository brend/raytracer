//
//  BitmapCanvas.swift
//  Raytracer
//
//  Created by Philipp Brendel on 03.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation
import Cocoa

class BitmapCanvas: Canvas {
    let size: CGSize
    let bitmap: NSBitmapImageRep
    let buffer: UnsafeMutablePointer<UInt8>
    
    init?(size: CGSize) {
        guard let bitmap = NSBitmapImageRep(
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
            bitsPerPixel: 24),
        let data = bitmap.bitmapData
        else {
            return nil
        }
        
        self.size = size
        self.bitmap = bitmap
        self.buffer = data
    }
    
    func fillPixel(_ i: Int, _ j: Int, color: Color) {
        let offset = 3 * (j * Int(size.width) + i)
        
        buffer[offset + 0] = color.red
        buffer[offset + 1] = color.green
        buffer[offset + 2] = color.blue
    }
    
    func image() -> NSImage {
        let image = NSImage()
        
        image.addRepresentation(bitmap)
        
        return image
    }
}
