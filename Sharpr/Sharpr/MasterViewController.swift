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
    @IBOutlet weak var resultImageView: UIImageView!

    @IBAction func resultAsTextButton(_ sender: Any) {
        resultTextView.text = resultTextView.text.appending((mathView?.resultAsText())!)
    }
    
    @IBAction func clearTextButton(_ sender: Any) {
        mathView?.clear(true)
    }
    
    @IBAction func resultAsImageButton(_ sender: Any) {
        resultImageView.image = mathView?.resultAsImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let childVC = childViewControllers[0]
        mathView = childVC.view as! MAWMathView?
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
