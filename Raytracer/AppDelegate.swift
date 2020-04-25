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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupScene()
        
        let sphere = Sphere(center: .init(x: 2, y: 1, z: 0), radius: 3)
        let ray = Ray(origin: .init(x: 0, y: 1, z: 0), direction: .init(x: 1, y: 3, z: 0))
        let intersections = sphere.intersection(with: ray)
        
        print("OK")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func setupScene() {
        scene.solids.append(Sphere(center: .zero, radius: 100))
        scene.light = Vector(x: 200, y: 200, z: 200)
        scene.camera = Vector(x: 0, y: 0, z: 400)
        
        let image = NSImage(named: "zapbug")
        
        imageView.image = image
    }
}

