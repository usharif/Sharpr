//
//  SLViewController.swift
//  Sharpr
//
//  Created by Umair Sharif on 11/16/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

import UIKit

class SLViewController: UIViewController {
    var singleLineView: SLTWSingleLineWidget?

    @IBOutlet weak var textOutlet: UITextView!
    
    @IBAction func makeText(_ sender: UIButton) {
        textOutlet.text = textOutlet.text.appending((singleLineView?.text)!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let childVC = childViewControllers[0]
        singleLineView = childVC.view as! SLTWSingleLineWidget?

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
