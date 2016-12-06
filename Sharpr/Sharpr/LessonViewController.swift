//
//  LessonViewController.swift
//  Sharpr
//
//  Created by Umair Sharif on 11/20/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController, SLTWSingleLineWidgetDelegate {
    var mathView: MAWMathView?
    var singleLineView: SLTWSingleLineWidget?
    
    @IBOutlet weak var resultTextView: UITextView!
    
    @IBAction func clearTextButton(_ sender: Any) {
        mathView?.clear(true)
        singleLineView?.clear()
    }
    
    @IBAction func resultAsImageButton(_ sender: Any) {
        //create and NSTextAttachment and add your image to it.
        let attachment = NSTextAttachment()
        attachment.image = mathView?.resultAsImage()
        
        //put your NSTextAttachment into and attributedString
        let attString = NSAttributedString(attachment: attachment)
        
        //add this attributed string to the current position.
        resultTextView.textStorage.insert(attString, at: resultTextView.selectedRange.length)
        //resultTextView.textStorage.append(attString)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleLineViewChildVC = childViewControllers[0]
        singleLineView = singleLineViewChildVC.view as! SLTWSingleLineWidget?
        
        let mathViewChildVC = childViewControllers[1]
        mathView = mathViewChildVC.view as! MAWMathView?
        
        //sets the beautificationOption on mathView
        mathView?.beautificationOption = .fontify
        
        //set the singleLineView delegate
        singleLineView?.delegate = self
        
    }
    
    func singleLineWidget(_ sender: SLTWSingleLineWidget!, didChangeText text: String!, intermediate: Bool) {
        resultTextView.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
