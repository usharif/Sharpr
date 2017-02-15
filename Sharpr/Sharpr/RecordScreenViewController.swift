//
//  RecordScreenViewController.swift
//  Sharpr
//
//  Created by Umair Sharif on 2/14/17.
//  Copyright © 2017 2itionAcademy. All rights reserved.
//

import UIKit
import ReplayKit

class RecordScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //recButton.titleLabel?.text = "Start Recording"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var recButton: UIButton!
    
    @available(iOS, deprecated: 9.0)
    @IBAction func startRec(_ sender: UIButton) {
        recButton.titleLabel?.text = "Stop Recording"
        let recorder = RPScreenRecorder.shared()
        recorder.startRecording(withMicrophoneEnabled: true, handler: nil)
    }
    
    @IBAction func endRec(_ sender: UIButton) {
        recButton.titleLabel?.text = "Start Recording"
        let recorder = RPScreenRecorder.shared()
        recorder.stopRecording { (preview, error) in
            preview?.popoverPresentationController?.sourceView = self.view
            self.present(preview!, animated: true)
        }
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
