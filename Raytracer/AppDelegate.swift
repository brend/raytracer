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
    
    var cameraAngle = CGFloat.zero
    
    var imageCount = 0
    
    var keys = Keys(rawValue: 0)
        
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        imageView.becomeFirstResponder()
        
        Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) {
            timer in
            
            executeWithTiming {
                let image = self.renderScene()
                
                self.imageView.image = image
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func renderScene() -> NSImage {
        scene.light = Vector(x: 200, y: -200, z: 100)

        updateCamera()
                        
        scene.solids.removeAll()
        scene.solids.append(Sphere(center: .zero, radius: 50, color: .blue, shadowColor: .darkBlue, id: 1))
        scene.solids.append(Sphere(center: Vector(x: 80*sin(angle), y: 80*cos(angle), z: 50), radius: 20, color: .yellow, shadowColor: .darkYellow, id: 2))
        scene.solids.append(Sphere(center: Vector(x: 0, y: -50, z: 0), radius: 10, color: .red, shadowColor: .darkRed, id: 3))
                
        angle += -.pi / 200

        let canvas = BitmapCanvas(size: CGSize(width: 400, height: 400))!
        
        scene.render(on: canvas)

        return canvas.image()
    }
    
    func updateCamera() {
        scene.camera = scene.camera.move(input: keys)
    }
    
    @IBAction func toggleInterlaced(_ sender: NSMenuItem) {
        if sender.state == NSControl.StateValue.on {
            scene.interlaced = false
            sender.state = NSControl.StateValue.off
        } else {
            scene.interlaced = true
            sender.state = NSControl.StateValue.on
        }
    }
}

