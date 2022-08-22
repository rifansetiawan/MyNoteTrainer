//
//  ClefViewModel.swift
//  MyNoteTrainer
//
//  Created by Mikhael Budi Mulya Marpaung on 22/08/22.
//

import Foundation
import AVKit

class ClefViewModel {
    var players: [Int8 : ClefAudioPlayer] = [:]
    
    init() {
        for i in 60...71 {
            players[Int8(i)] = ClefAudioPlayer(fileName: String(i), fileExtension: "wav")
            
        }
    }
    
    func play(toneKey: Int8) {
        players[toneKey]?.playAudio(toneKey: toneKey)
    }
}

