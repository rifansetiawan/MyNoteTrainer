//
//  MusicalNoteQuizPlayerManager.swift
//  MyNoteTrainer
//
//  Created by Widya Limarto on 24/08/22.
//

import Foundation
import AVFoundation

class MusicalNoteQuizPlayerManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    @Published var playbackProgress: Float = 0.0
    @Published var isPlaying: Bool = false
    var displayLink: CADisplayLink?
    
    init(fileName: String, ext: String) {
        super.init()
        print("init")
        do{
            let soundURL = Bundle.main.url(forResource: fileName, withExtension: ext)!
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.delegate = self
            displayLink = CADisplayLink(
                target: self,
                selector: #selector(updatePlaybackStatus))
        } catch let error{
            print("init player failed", error.localizedDescription)
            // couldn't load file :(
        }
        
    }
    
    func play() {
        guard let audioPlayer = audioPlayer else {
            return
        }
        displayLink = CADisplayLink(
            target: self,
            selector: #selector(updatePlaybackStatus))
        startUpdatingPlaybackStatus()
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        isPlaying = true
    }
    
    func startUpdatingPlaybackStatus() {
        displayLink?.add(to: .main, forMode: .default)
    }

    func stopUpdatingPlaybackStatus() {
        displayLink?.invalidate()
        playbackProgress = 0.0
    }
    
    func stop() {
        stopUpdatingPlaybackStatus()
        audioPlayer?.stop()
    }
    
    func pause() {
        audioPlayer?.pause()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopUpdatingPlaybackStatus()
        isPlaying = false
    }
    
    @objc func updatePlaybackStatus() {
        guard let audioPlayer = audioPlayer else {
            return
        }
        playbackProgress = Float((audioPlayer.currentTime) / (audioPlayer.duration))
    }
}
