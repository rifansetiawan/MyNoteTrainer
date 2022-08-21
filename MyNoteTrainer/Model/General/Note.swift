//
//  Note.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 21/08/22.
//

import Foundation

enum Beat: Double, CaseIterable {
    case full = 4
    case half = 2
    case quarter = 1
    case eighth = 0.5
    case sixteenth = 0.25
}

enum Tone: String {
    case C
    case D
    case E
    case F
    case G
    case A
    case B
    
    
}

enum Accidental: String {
    case sharp
    case flat
}

struct Sound {
    var tone: Tone
    var octave: Int = 4
    var accidental: Accidental?
    
    var position: Double {
        print(self.tone.rawValue)
        let x = (Double(octave) - 4.0) * 3.5
        switch(self.tone) {
        case .C:
            return 1.5 - x //c4 -> 1.5, c5 -> -2
        case .D:
            return 1 - x
        case .E:
            return 0.5 - x
        case .F:
            return 0 - x
        case .G:
            return -0.5 - x
        case .A:
            return -1 - x
        case .B:
            return -1.5 - x //b4 -> -1.5 , b5 -> -5
        }
        
    }
}

struct NoteType {
    var name: String
    var image: String
    var beat: Beat
    var isRest: Bool = false
    
    static let fullNote = NoteType(name: "Full", image: "wholeNote", beat: .full)
    static let halfNote = NoteType(name: "Half", image: "halfNote", beat: .half)
    static let quarterNote = NoteType(name: "Quarter", image: "quarterNote", beat: .quarter)
    static let eighthNote = NoteType(name: "Eighth", image: "eightNote", beat: .eighth)
    static let fullRest = NoteType(name: "FullRest", image: "fullRest", beat: .full, isRest: true)
    static let halfRest = NoteType(name: "HalfRest", image: "halfRest", beat: .half, isRest: true)
    static let quarterRest = NoteType(name: "QuarterRest", image: "quarterRest", beat: .quarter, isRest: true)
    static let eighthRest = NoteType(name: "EightRest", image: "eighthRest", beat: .eighth, isRest: true)
}


struct Note {
    var id: UUID = UUID()
    var noteType: NoteType
    var sound: Sound
    
}

