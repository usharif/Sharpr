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
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var questionImage: UIImageView!
    var isRecording : Bool = false
    
    var passedInImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.clearCanvas(false)
        questionImage.image = passedInImage
        isRecording = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS, deprecated: 9.0)
    @IBAction func startRec(_ sender: UIButton) {
        if !isRecording {
            sender.setTitle("Stop", for: .normal)
            let recorder = RPScreenRecorder.shared()
            recorder.startRecording(withMicrophoneEnabled: true, handler: nil)
            isRecording = true
        } else {
            sender.setTitle("Start Recording", for: .normal)
            let recorder = RPScreenRecorder.shared()
            recorder.stopRecording { (preview, error) in
                preview?.popoverPresentationController?.sourceView = self.view
                self.present(preview!, animated: true)
            }
            isRecording = false
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        canvasView.clearCanvas(true)
    }
    
    // Shake to clear screen
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        canvasView.clearCanvas(true)
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
