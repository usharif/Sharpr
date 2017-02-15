//
//  QuestionDetailViewController.swift
//  Sharpr
//
//  Created by Umair Sharif on 2/15/17.
//  Copyright © 2017 2itionAcademy. All rights reserved.
//

import UIKit
import CoreData

class QuestionDetailViewController: UIViewController {
    var titleStr = ""
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var decoyOneLabel: UILabel!
    @IBOutlet weak var decoyTwoLabel: UILabel!
    @IBOutlet weak var decoyThreeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let questionObject = CoreDataManager.fetchObject(entity: "CDQuestion", title: titleStr)
        let data = questionObject.value(forKey: "questionData") as! Data
        let image = UIImage(data: data)
        questionImageView.image = image
        
        let answer = questionObject.value(forKey: "answerString") as! String
        answerLabel.text = answer
        let d1 = questionObject.value(forKey: "decoy1String") as! String
        decoyOneLabel.text = d1
        let d2 = questionObject.value(forKey: "decoy2String") as! String
        decoyTwoLabel.text = d2
        let d3 = questionObject.value(forKey: "decoy3String") as! String
        decoyThreeLabel.text = d3
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
