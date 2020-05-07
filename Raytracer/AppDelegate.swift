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
    
    @IBOutlet weak var interlacedCheckbox: NSSwitch!
    
    var demoDistance = CGFloat(0)

    let scene = Scene()
    
    var angle = CGFloat.pi
    
    var imageCount = 0
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) {
            timer in
            
            executeWithTiming {
                let image = self.renderScene()
                
                self.imageView.image = image
                               
                self.imageCount += 1
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    func renderScene() -> NSImage {
        //let cameraPosition = Vector(x: 0, y: 0, z: 500)

        //scene.camera = Ray(p: cameraPosition, q: .zero - cameraPosition)
        scene.light = Vector(x: 200, y: -200, z: 100)

        scene.interlaced = self.interlacedCheckbox.state == .on
                
        scene.solids.removeAll()
        scene.solids.append(Sphere(center: .zero, radius: 50, color: .blue, shadowColor: .darkBlue, id: 1))
        scene.solids.append(Sphere(center: Vector(x: 80*sin(angle), y: 80*cos(angle), z: 50), radius: 20, color: .yellow, shadowColor: .darkYellow, id: 2))

        angle += -.pi / 200

        let canvas = BitmapCanvas(size: CGSize(width: 400, height: 400))!
        
        scene.render(on: canvas)

        return canvas.image()
    }

    
    @IBAction func distanceChanged(_ sender: NSSlider) {
        self.demoDistance = CGFloat(sender.floatValue)
    }
}

