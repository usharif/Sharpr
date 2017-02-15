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
    var finalText = NSAttributedString(string: "")
    @IBOutlet weak var resultTextView: UITextView!
    
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
    
    // MARK: Single Line Widget Functions
    
    @IBAction func clearText(_ sender: UIButton) {
        singleLineView?.clear()
    }
    
    @IBAction func addText(_ sender: UIButton) {
        let currText = resultTextView.attributedText!
        let combo = NSMutableAttributedString()
        combo.append(currText)
        combo.append(finalText)
        resultTextView.attributedText = combo
        singleLineView?.clear()
    }
    
    // MARK: Math Widget Functions
    
    @IBAction func clearEquation(_ sender: UIButton) {
        mathView?.clear(true)
    }
    
    @IBAction func addEquation(_ sender: UIButton) {
        let attachment = NSTextAttachment()
        attachment.image = mathView?.resultAsImage()
        let attString = NSAttributedString(attachment: attachment)
        
        //Adding spaces on either side of the image
        resultTextView.textStorage.append(NSAttributedString(string: " "))
        resultTextView.textStorage.append(attString)
        resultTextView.textStorage.append(NSAttributedString(string: " "))
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
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Single Line Widget Delegate
    
    func singleLineWidget(_ sender: SLTWSingleLineWidget!, didChangeText text: String!, intermediate: Bool) {
        let attString = NSAttributedString(string: text)
        finalText = attString
    }
    
}
