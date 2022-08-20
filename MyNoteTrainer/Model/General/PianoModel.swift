//
//  PianoModel.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 20/08/22.
//

import Foundation

class SoundModel {

    let piano = PianoSound()

    func called(keyInfo: KeyInfo) {
        Swift.print(keyInfo.description)
        if keyInfo.isPressed {
            piano.play(keyInfo: keyInfo)
        } else {
            piano.stop(keyInfo: keyInfo)
        }
    }

}
