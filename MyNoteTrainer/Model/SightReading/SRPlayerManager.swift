//
//  SRPlayerManager.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 22/08/22.
//

import Foundation
import QuartzCore

// key, timing tiap note ketika di garis, boolean benar atau salah

class SRPlayerManager: ObservableObject {
    
    @Published var playingTimestamp : TimeInterval = -1
    @Published var startTime : TimeInterval = -1
    @Published var endTime : TimeInterval = -1
    @Published var isPlaying: Bool = false
    @Published var playingIndex: Int = -1
    
    var noteInterval: [TimeInterval]
    var noteTiming: [TimeInterval]
    var totalInterval: TimeInterval!
    var displayLink : CADisplayLink!
    var tolerance: TimeInterval = 0.125
    
    
    init(notes: [Note], bpm: Int = 60, offsetBpm: Int, noteInterval: [TimeInterval], noteTiming: [TimeInterval]) {
        
        self.noteTiming = noteTiming
        self.noteInterval = noteInterval
        // hitung second per nada, //1,2,2,4,4-> 60 ,120
//        noteInterval = SRHelper.convertBeatToTimeInterval(notes: notes, bpm: bpm, offsetBpm: offsetBpm)
//        
//        noteTiming = SRHelper.countNoteTiming(noteInterval: noteInterval)
//        print(noteTiming)
//        print(noteInterval)
        // hitung total seconds nada
        totalInterval = noteInterval.reduce(0, +)
//        print(totalInterval)
        // cukupkah
        
//        self.displayLink = CADisplayLink(
//            target: self,
//            selector: #selector(trackPlayIndex))
    }
    
    func start() {
        self.isPlaying = true
        restart()
        play()
    }
    
    func stop() {
        
        self.isPlaying = false
    }
    
    func restart() {
        self.startTime = -1
        self.endTime = -1
        self.playingTimestamp = -1
        self.playingIndex = -1
    }
    
    @objc private func trackPlayIndex(displayLink:CADisplayLink){
        // ketika ini jalan, tambah delay 1 detik
//        DispatchQueue.global().async { [self] in
            if startTime == -1 {
                startTime = displayLink.timestamp + 1.0
                endTime = startTime + totalInterval
                self.play()
            }else {
                self.playingTimestamp = displayLink.timestamp
                if (playingIndex+1 < noteTiming.count) {
                    if(abs(playingTimestamp - (noteTiming[playingIndex+1] + startTime)) < tolerance) {
                        playingIndex += 1
                    }
                }
                if(displayLink.timestamp > self.endTime + 0.1) {
                    displayLink.invalidate()
                    self.stop()
                }
            }
//        }
        
    }
    
    
    func play() {
        displayLink = CADisplayLink(target: self, selector: #selector(trackPlayIndex))
        displayLink.add(to: .main, forMode: .default)
    }
}
