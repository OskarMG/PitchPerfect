//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Oscar Martínez Germán on 28/12/21.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //MARK: - UIElements
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var revertButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //MARK: - Properties
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        configureUIButtons()
    }
    
    //MARK: - Methods
    func configureUIButtons() {
        for button in [slowButton, fastButton, lowPitchButton, highPitchButton, echoButton, revertButton, stopButton] {
            button?.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    func playSound(tag: Int) {
        switch (ButtonType(rawValue: tag)!) {
            case .slow:     playSound(rate:   0.5)
            case .fast:     playSound(rate:   1.8)
            case .chipmunk: playSound(pitch:  1000)
            case .vader:    playSound(pitch: -1000)
            case .echo:     playSound(echo:   true)
            case .reverb:   playSound(reverb: true)
        }
    }
    
    //MARK: - Events
    @IBAction func playSoundForButton(_ sender: UIButton) {
        playSound(tag: sender.tag)
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }

}
