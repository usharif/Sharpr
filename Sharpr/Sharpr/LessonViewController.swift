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
        let doneAction = UIAlertController(title: "Name required", message: "Please name your lesson", preferredStyle: .alert)
        doneAction.addTextField(configurationHandler: nil)
        doneAction.addAction(UIAlertAction(title: "Ok", style: .default,
                                           handler: {_ in self.dismiss(animated: true,
                                                                       completion: {self.saveLesson(name: doneAction.textFields![0].text!)})}))
        doneAction.addAction(UIAlertAction(title: "Cancel", style: .cancel,
                                           handler: {_ in doneAction.dismiss(animated: true, completion: nil)}))
        
        present(doneAction, animated: true, completion: nil)
    }
    
    func saveLesson(name: String) {
        let renderer = UIGraphicsImageRenderer(size: resultTextView.bounds.size)
        let image = renderer.image { ctx in
            resultTextView.drawHierarchy(in: resultTextView.bounds, afterScreenUpdates: true)
        }
        
        if let data = UIImagePNGRepresentation(image) {
            let filename = getDocumentsDirectory().appendingPathComponent(name)
            try? data.write(to: filename)
            print(filename)
        }
//        Lessons.list.append(name)

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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
