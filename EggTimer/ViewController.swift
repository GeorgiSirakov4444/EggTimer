//
//  ViewController.swift
//  EggTimer
//
//  Created by Georgi Sirakov on 12.12.22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var timer = Timer()
    let eggTimes = ["Soft": 360, "Medium": 480, "Hard": 720]
    var secondsPassed = 0
    var totalTime = 0
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelector(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = (sender.titleLabel?.text)!
        totalTime = eggTimes[hardness]!
        secondsPassed = 0
        progressView.progress = 0.0
        titleLabel.text = hardness
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

        
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1

            progressView.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "Done !"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}

