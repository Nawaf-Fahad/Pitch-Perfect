//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Nawaf Alotaibi on 01/02/2023.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate{
    var audioRecorder: AVAudioRecorder!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var RecordLabel: UILabel!
    @IBOutlet weak var RecordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        StopButton.isEnabled = false
    }

    @IBAction func recordAudio(_ sender: UIButton) {
        print("Record button Was Pressed")
        RecordLabel.text = "Recording in Progress"
        StopButton.isEnabled = true
        RecordButton.isEnabled = false
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
               let recordingName = "recordedVoice.wav"
               let pathArray = [dirPath, recordingName]
               let filePath = URL(string: pathArray.joined(separator: "/"))

               let session = AVAudioSession.sharedInstance()
               try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

               try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
               audioRecorder.delegate = self
               audioRecorder.isMeteringEnabled = true
               audioRecorder.prepareToRecord()
               audioRecorder.record()
    }
    @IBAction func stopRecording(_ sender: UIButton) {
        RecordButton.isEnabled = true
            StopButton.isEnabled = false
            RecordLabel.text = "Tap to Record"
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("Recording was not successful")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.reordedAudioURL = recordedAudioURL
        }
    }
}

