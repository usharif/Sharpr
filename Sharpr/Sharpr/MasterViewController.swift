//
//  MasterViewController.swift
//  Sharpr
//
//  Created by Umair Sharif on 11/2/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    var mathView: MAWMathView?
    
    @IBOutlet weak var resultTextView: UITextView!

    @IBAction func resultAsTextButton(_ sender: Any) {
        resultTextView.text = resultTextView.text.appending((mathView?.resultAsText())!)
    }
    
    @IBAction func clearTextButton(_ sender: Any) {
        mathView?.clear(true)
    }
    
    @IBAction func resultAsImageButton(_ sender: Any) {
        //create and NSTextAttachment and add your image to it.
        let attachment = NSTextAttachment()
        attachment.image = mathView?.resultAsImage()
        
        //put your NSTextAttachment into and attributedString
        let attString = NSAttributedString(attachment: attachment)
        
        //add this attributed string to the current position.
        resultTextView.textStorage.insert(attString, at: resultTextView.selectedRange.location)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let childVC = childViewControllers[0]
        mathView = childVC.view as! MAWMathView?
        
        //sets the beautificationOption
        mathView?.beautificationOption = .fontify
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
