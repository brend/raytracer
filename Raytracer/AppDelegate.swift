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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) {
            timer in
            
            self.executeWithTiming {
                let image = self.renderScene()
                
                self.imageView.image = image
               
                self.imageCount += 1
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func executeWithTiming(task: () -> Void)
    {
        let start = DispatchTime.now()
        task()
        let end = DispatchTime.now()
    
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
    
        print("Task duration: \(timeInterval) seconds")
    }

    func renderScene() -> NSImage {
        scene.light = Vector(x: 100, y: 100, z: 100)
        
        scene.solids.removeAll()
        scene.solids.append(Sphere(center: .zero, radius: 50, color: .blue, shadowColor: .darkBlue, id: 1))
        scene.solids.append(Sphere(center: Vector(x: 80 * cos(angle), y: 80 * -sin(angle), z: 0), radius: 20, color: .yellow, shadowColor: .darkYellow, id: 2))
        
        scene.solids.append(Sphere(center: scene.light, radius: 10, color: .yellow, shadowColor: .yellow, id: 3))
        
        let cameraPosition = Vector(x: 0, y: 0, z: 500)
        scene.camera = Ray(p: cameraPosition,
                           q: .zero - cameraPosition)
        
        angle += .pi / 80
        
        let image = scene.render(size: CGSize(width: 400, height: 400))
        
        return image
    }
}

