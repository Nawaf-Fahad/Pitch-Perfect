//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Nawaf Alotaibi on 01/02/2023.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
        var recordedAudioURL: URL!
       var audioFile:AVAudioFile!
       var audioEngine:AVAudioEngine!
       var audioPlayerNode: AVAudioPlayerNode!
       var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
          setupAudio()
      }
    // MARK: Outlets

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    // MARK: Actions

    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }

            configureUI(.playing)
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    

}
