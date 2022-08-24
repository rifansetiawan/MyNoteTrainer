//
//  ClefAudioPlayer.swift
//  MyNoteTrainer
//
//  Created by Mikhael Budi Mulya Marpaung on 22/08/22.
//

import Foundation
import AudioKit

struct ClefAudioPlayer {
    let engine = AudioEngine()
    private var instrument = MIDISampler(name: "Instrument 1")
    
    init(fileName: String, fileExtension: String){
        let verb = Reverb(instrument)
        verb.loadFactoryPreset(.smallRoom)
        engine.output = verb
        do {
            if let fileURL = Bundle.main.url(forResource: "Sounds/Sampler Instruments/sawPiano1", withExtension: "exs") {
                try instrument.loadInstrument(url: fileURL)
            } else {
                Log("Could not find file")
            }
        } catch {
            Log("Could not load instrument")
        }
        try! engine.start()
        
    }
    
    func playAudio(toneKey:Int8 ) {
        instrument.play(noteNumber: MIDINoteNumber(toneKey), velocity: 90, channel: 0)
        
    }
}
