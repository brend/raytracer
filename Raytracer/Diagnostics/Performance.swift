//
//  Performance.swift
//  Raytracer
//
//  Created by Philipp Brendel on 07.05.20.
//  Copyright © 2020 Entenwolf Software. All rights reserved.
//

import Foundation

func executeWithTiming(task: () -> Void)
{
    let start = DispatchTime.now()
    task()
    let end = DispatchTime.now()

    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
    let timeInterval = Double(nanoTime) / 1_000_000_000

    print("Task duration: \(timeInterval) seconds")
}
