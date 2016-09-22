//
//  ViewController.swift
//  2ition
//
//  Created by Umair Sharif on 9/19/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var canvasView: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.clearCanvas(false)
    }
    
    // Shake to clear screen
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        canvasView.clearCanvas(true)
    }
}

