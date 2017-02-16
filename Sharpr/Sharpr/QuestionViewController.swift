//
//  QuestionViewController.swift
//  Sharpr
//
//  Created by Umair Sharif on 11/20/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, SLTWSingleLineWidgetDelegate {
    var mathView: MAWMathView?
    var singleLineView: SLTWSingleLineWidget?
    var finalText = NSAttributedString(string: "")
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var decoyOneField: UITextField!
    @IBOutlet weak var decoyTwoField: UITextField!
    @IBOutlet weak var decoyThreeField: UITextField!
    
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
        
        answerField.layer.borderWidth = 1
        answerField.layer.cornerRadius = 5
        answerField.layer.masksToBounds = true
        answerField.layer.borderColor = UIColor.green.cgColor
        
        decoyOneField.layer.borderWidth = 1
        decoyOneField.layer.cornerRadius = 5
        decoyOneField.layer.masksToBounds = true
        decoyOneField.layer.borderColor = UIColor.red.cgColor
        
        decoyTwoField.layer.borderWidth = 1
        decoyTwoField.layer.cornerRadius = 5
        decoyTwoField.layer.masksToBounds = true
        decoyTwoField.layer.borderColor = UIColor.red.cgColor
        
        decoyThreeField.layer.borderWidth = 1
        decoyThreeField.layer.cornerRadius = 5
        decoyThreeField.layer.masksToBounds = true
        decoyThreeField.layer.borderColor = UIColor.red.cgColor
        
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.whiteColor().CGColor
        
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
    
    @IBAction func saveButton(_ sender: UIButton) {
        view.endEditing(true) // DO NOT REMOVE. This is done to close keyboard, so the right context can be given to create image from resultTextView
        let doneAction = UIAlertController(title: "Name required", message: "Please name your question", preferredStyle: .alert)
        doneAction.addTextField(configurationHandler: nil)
        doneAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            _ in self.dismiss(animated: true, completion: {
                let imageData = self.generateImageAsData()
                CoreDataManager.saveQuestion(entity: "CDQuestion",
                                             title: (doneAction.textFields?[0].text)!,
                                             questionData: imageData,
                                             answer: self.answerField.text!,
                                             d1: self.decoyOneField.text!,
                                             d2: self.decoyTwoField.text!,
                                             d3: self.decoyThreeField.text!
                )}
            )}
        ))
        doneAction.addAction(UIAlertAction(title: "Cancel", style: .cancel,
                                           handler: {_ in doneAction.dismiss(animated: true, completion: nil)}))
        
        present(doneAction, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Private fucntions
    
    private func generateImageAsData() -> NSData {
//        let renderer = UIGraphicsImageRenderer(size: resultTextView.bounds.size)
//        let image = renderer.image { ctx in
//            resultTextView.drawHierarchy(in: resultTextView.bounds, afterScreenUpdates: true)
//        }
//        let imageData = NSData(data: UIImageJPEGRepresentation(image, 1.0)!)
//        return imageData
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(resultTextView.bounds.size, resultTextView.isOpaque, 0.0)
        resultTextView.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageData = NSData(data: UIImageJPEGRepresentation(image!, 1.0)!)
        return imageData
    }
    
    private func saveQuestion(name: String) -> String {
        var path = ""
        let renderer = UIGraphicsImageRenderer(size: resultTextView.bounds.size)
        let image = renderer.image { ctx in
            resultTextView.drawHierarchy(in: resultTextView.bounds, afterScreenUpdates: true)
        }
        
        if let data = UIImagePNGRepresentation(image) {
            let filename = getDocumentsDirectory().appendingPathComponent(name)
            try? data.write(to: filename)
            print(filename)
            path = filename.absoluteString
        }
        return path
    }
    
    private func getDocumentsDirectory() -> URL {
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
