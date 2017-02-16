//
//  CanvasView.swift
//  Sharpr
//
//  Created by Umair Sharif on 9/21/16.
//  Copyright © 2016 Sharpr. All rights reserved.
//

import UIKit

let π = CGFloat(M_PI)

class CanvasView: UIImageView {
    
    private let forceSensitivity: CGFloat = 4.0
    
    // Parameters
    fileprivate let defaultLineWidth:CGFloat = 6
    
    fileprivate var drawColor: UIColor = UIColor.black
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // Draw previous image into context
        image?.draw(in: bounds)
        
        var touches = [UITouch]()
        
        if let coalescedTouches = event?.coalescedTouches(for: touch) {
            touches = coalescedTouches
        } else {
            touches.append(touch)
        }
                
        for touch in touches {
            drawStroke(context, touch: touch)
        }
        
        // Update image
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    fileprivate func drawStroke(_ context: CGContext?, touch: UITouch) {
        let previousLocation = touch.previousLocation(in: self)
        let location = touch.location(in: self)
        
        // Calculate line width for drawing stroke
        let lineWidth = lineWidthForDrawing(context, touch: touch)
        
        // Set color
        drawColor.setStroke()
        
        // Configure line
        context!.setLineWidth(lineWidth)
        context!.setLineCap(.round)
        
        
        // Set up the points
        context!.move(to: CGPoint(x: previousLocation.x, y: previousLocation.y))
        context!.addLine(to: CGPoint(x: location.x, y: location.y))
        // Draw the stroke
        context!.strokePath()
        
    }
    
    fileprivate func lineWidthForDrawing(_ context: CGContext?, touch: UITouch) -> CGFloat {
        
        var lineWidth = defaultLineWidth
        
        if touch.force > 0 {
            lineWidth = touch.force * forceSensitivity
        }
        
        return lineWidth
    }
    
    func clearCanvas(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
                }, completion: { finished in
                    self.alpha = 1
                    self.image = nil
            })
        } else {
            image = nil
        }
    }
}
