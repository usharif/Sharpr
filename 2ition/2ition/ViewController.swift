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
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choices: UISegmentedControl!
    
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
    
    
    
    @IBOutlet weak var answerTitle: UIButton!
    @IBAction func answer(_ sender: AnyObject) {
        let correctAnswerAlert = UIAlertController(title: "Correct!", message: "Your chosen answer was correct.", preferredStyle: UIAlertControllerStyle.alert)
        correctAnswerAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        let incorrectAnswerAlert = UIAlertController(title: "Incorrect!", message: "Your chosen answer was not correct, please try again.", preferredStyle: UIAlertControllerStyle.alert)
        incorrectAnswerAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        if ((choices.titleForSegment(at: choices.selectedSegmentIndex)!) == "10") {
            self.present(correctAnswerAlert, animated: true, completion: nil)
        } else {
            self.present(incorrectAnswerAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = "What is 5+5?"
        choices.setTitle("6", forSegmentAt: 0)
        choices.setTitle("10", forSegmentAt: 1)
        choices.setTitle("-8", forSegmentAt: 2)
        choices.setTitle("12", forSegmentAt: 3)
        answerTitle.setTitle("Choose an answer first", for: UIControlState.normal)
        canvasView.clearCanvas(false)
    }
    
    
    // Shake to clear screen
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        canvasView.clearCanvas(true)
    }
    
    
}

