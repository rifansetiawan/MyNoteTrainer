//
//  PianoView2.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 20/08/22.
//

import AudioKit
import AudioKitUI
import AVFoundation
import Keyboard
import SoundpipeAudioKit
import SwiftUI
import Tonic

class InstrumentEXSConductor: ObservableObject {
    let engine = AudioEngine()
    private var instrument = MIDISampler(name: "Instrument 1")
    @Published var noteNumber: Int8?

    func noteOn(pitch: Pitch, point _: CGPoint?) {
        instrument.play(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), velocity: 90, channel: 0)
        self.noteNumber = pitch.midiNoteNumber
    }

    func noteOff(pitch: Pitch) {
        instrument.stop(noteNumber: MIDINoteNumber(pitch.midiNoteNumber), channel: 0)
    }

    init() {
        engine.output = instrument
    }

    func start() {
        // Load EXS file (you can also load SoundFonts and WAV files too using the AppleSampler Class)
        do {
            if let fileURL = Bundle.main.url(forResource: "Sounds/Sampler Instruments/sawPiano1", withExtension: "exs") {
                try instrument.loadInstrument(url: fileURL)
            } else {
                Log("Could not find file")
            }
        } catch {
            Log("Could not load instrument")
        }
        do {
            try engine.start()
        } catch {
            Log("AudioKit did not start!")
        }
    }

    func stop() {
        engine.stop()
    }
}

struct InstrumentEXSView: View {
    @ObservedObject var conductor: InstrumentEXSConductor

    var body: some View {
        ZStack {
            Keyboard(layout: .piano(pitchRange: Pitch(60) ... Pitch(85)),
                     noteOn: conductor.noteOn,
                     noteOff: conductor.noteOff)
                .onAppear {
                    self.conductor.start()
                }
                .onDisappear {
                    self.conductor.stop()
            }
        }.background(Color.primaryColor)
    }
}

struct InstrumentEXSView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentEXSView(conductor: InstrumentEXSConductor())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

