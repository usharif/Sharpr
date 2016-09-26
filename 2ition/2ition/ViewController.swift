//
//  ViewController.swift
//  2ition
//
//  Created by Umair Sharif on 9/19/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataRepo = Data.init()
    
    //Outlets
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choices: UISegmentedControl!
    @IBOutlet weak var clearCanvasTitle: UIButton!
    @IBOutlet weak var answerTitle: UIButton!

    
    //Actions
    @IBAction func indexChanged(sender:UISegmentedControl) {
        switch choices.selectedSegmentIndex {
        case 0:
            answerTitle.setTitle("Select answer as \(choices.titleForSegment(at: 0)!)?", for: UIControlState.normal)
        case 1:
            answerTitle.setTitle("Select answer as \(choices.titleForSegment(at: 1)!)?", for: UIControlState.normal)
        case 2:
            answerTitle.setTitle("Select answer as \(choices.titleForSegment(at: 2)!)?", for: UIControlState.normal)
        case 3:
            answerTitle.setTitle("Select answer as \(choices.titleForSegment(at: 3)!)?", for: UIControlState.normal)
        default:
            break
        }
    }
    
    @IBAction func clearCanvasButton(_ sender: AnyObject) {
        canvasView.clearCanvas(true)
    }
    
    
    @IBAction func answer(_ sender: AnyObject) {
        let correctAnswerAlert = UIAlertController(title: "Correct!", message: "Your chosen answer was correct.", preferredStyle: UIAlertControllerStyle.alert)
        correctAnswerAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        let incorrectAnswerAlert = UIAlertController(title: "Incorrect!", message: "Your chosen answer was not correct, please try again.", preferredStyle: UIAlertControllerStyle.alert)
        incorrectAnswerAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        if ((choices.titleForSegment(at: choices.selectedSegmentIndex)!) == dataRepo.getAnswer()) {
            self.present(correctAnswerAlert, animated: true, completion: { () -> Void in
                self.generateQuestionAnswer()
                self.answerTitle.setTitle("Choose an answer first", for: UIControlState.normal)
            })
        } else {
            self.present(incorrectAnswerAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = "Shake to clear \nor"
        clearCanvasTitle.setTitle("Click here", for: .normal)
        answerTitle.setTitle("Choose an answer first", for: UIControlState.normal)
        generateQuestionAnswer()
        canvasView.clearCanvas(false)
    }
    
    
    // Shake to clear screen
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        canvasView.clearCanvas(true)
    }
    
    private func generateQuestionAnswer() {
        dataRepo.setup()
        questionLabel.text = "What is \(dataRepo.getQuestion())?"
        var answerArray = dataRepo.getAnswerArray()
        var segmentAt = 0
        var index: Int
        
        while answerArray.count != 0 {
            index = Int(arc4random_uniform(UInt32(answerArray.count)))
            choices.setTitle(answerArray.remove(at: index), forSegmentAt: segmentAt)
            segmentAt += 1
        }
    }
    
}

