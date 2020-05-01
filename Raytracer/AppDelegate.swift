//
//  AppDelegate.swift
//  Raytracer
//
//  Created by Philipp Brendel on 18.04.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    @IBOutlet weak var imageView: NSImageView!

    let scene = Scene()
    
    var angle = CGFloat.pi
    
    var imageCount = 0
    
    var image = NSImage(size: NSSize(width: 200, height: 200))

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Timer.scheduledTimer(withTimeInterval: 1.0 / 24, repeats: true) {
            timer in
            self.setupScene()
            
            self.imageView.image = nil
            self.imageView.image = self.image
            
//            if let data = image.tiffRepresentation {
//                do {
//                    try data.write(to: URL(fileURLWithPath: "/Users/waldrumpus/Downloads/output/image_\(String(format: "%04d", arguments: [self.imageCount])).tiff"), options: .atomic)
//                } catch {
//                    print("error: \(error)")
//                }
//            }
            
            self.imageCount += 1
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func setupScene() {
        scene.light = Vector(x: 200, y: 200, z: 200)
        
        scene.solids.removeAll()
        scene.solids.append(Sphere(center: .zero, radius: 50, color: .blue, shadowColor: .darkBlue, id: 1))
        scene.solids.append(Sphere(center: Vector(x: 0, y: -100 + angle, z: 30), radius: 20, color: .yellow, shadowColor: .darkYellow, id: 2))
        
        scene.render(onto: self.image)
        
        angle += 1
    }
}

