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
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func setupScene() {
        scene.solids.append(Sphere(center: .zero, radius: 100))
        //scene.solids.append(NormCube())
        scene.light = Vector(x: 200, y: 200, z: 200)
        
        let image = scene.render(size: CGSize(width: 400, height: 400))
        
        imageView.image = image
    }
}

