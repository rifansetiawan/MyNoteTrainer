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

enum Tone: String, CaseIterable {
    case C
    case D
    case E
    case F
    case G
    case A
    case B
    
    var toneKey: Int8 {
        switch(self) {
        case .C:
            return 60
        case .D:
            return 62
        case .E:
            return 64
        case .F:
            return 65
        case .G:
            return 67
        case .A:
            return 69
        case .B:
            return 71
            
        }
    }
    
    var position: Double {
        switch(self) {
        case .C:
            return 1.5
        case .D:
            return 1
        case .E:
            return 0.5
        case .F:
            return 0
        case .G:
            return -0.5
        case .A:
            return -1
        case .B:
            return -1.5
        }
    }
    
    var accidentalPosition: Double {
        switch(self) {
        case .C:
            return -2
        case .D:
            return -2.5
        case .E:
            return -3
        case .F:
            return -3.5
        case .G:
            return -4
        case .A:
            return -1
        case .B:
            return -1.5
        }
    }
    
}

enum ToneKey: Int8, CaseIterable {
    case C = 60 // c5 -72 > 72-60 brp aldi? wkwkwk 12?
    case D = 62
    case E = 64
    case F = 65
    case G = 67
    case A = 69
    case B = 71
    
    
}

enum Accidental: Int8 {
    case sharp = 1
    case flat = -1
    
    var image : String {
        switch(self) {
        case .sharp:
            return "sharp"
        case .flat:
            return "flat"
        }
    }
}

enum ScaleType: String {
    case major
    case minor
    
    var interval: [Int8] {
        switch(self) {
        case .major:
            return [2,2,1,2,2,2,1]
        case .minor:
            return [2,1,2,2,1,2,2]
        }
    }
    
}

struct Sound {
    var tone: Tone
    var octave: Int = 4
    var accidental: Accidental?
    
    var key: Int8 {
        let res = (tone.toneKey + Int8(((octave - 4) * 12))) + (accidental?.rawValue ?? 0)
        return res
    }
    
    var position: Double {
        let x = (Double(octave) - 4.0) * 3.5
        return tone.position - x
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


struct Scale {
    var name: String
    var scaleType: ScaleType
    var scaleAcc: Accidental
    var accCount: Int
    var startSound: Sound
    
    var accTones: [Tone] {
        switch(scaleAcc) {
        case .sharp:
            let tones: [Tone] = [.F, .C, .G, .D, .A, .E, .B]
            return accCount > 0 ? Array(tones[0..<accCount]) : []
        case .flat:
            let tones: [Tone] = [.B, .E, .A, .D, .G, .C, .F]
            return accCount > 0 ? Array(tones[0..<accCount]) : []
        }
    }
    
    var notes: [Note] {
        var notes : [Note] = []
        var tones = Tone.allCases
        tones.shiftRight(p: tones.firstIndex(of: startSound.tone)!)
        tones.append(tones[0])
        for (idx, i) in tones.enumerated() {
            var sound = Sound(tone: i)
            if (accTones.contains(i)) {
                sound.accidental = scaleAcc
            }
            if( idx != 0 && notes[idx-1].sound.key > i.toneKey) {
                sound.octave += 1
            }
            notes.append(Note(noteType: .quarterNote, sound: sound))
        }
        return notes
    }
    
    
    static let CMaj = Scale(name: "C Major Scale", scaleType: .major, scaleAcc: .sharp, accCount: 0, startSound: Sound(tone: .C))
    static let GMaj = Scale(name: "G Major Scale", scaleType: .major, scaleAcc: .sharp, accCount: 1, startSound: Sound(tone: .G))
    static let DMaj = Scale(name: "D Major Scale", scaleType: .major, scaleAcc: .sharp, accCount: 2, startSound: Sound(tone: .D))
    static let AMaj = Scale(name: "A Major Scale", scaleType: .major, scaleAcc: .sharp, accCount: 3, startSound: Sound(tone: .A))
    static let EMaj = Scale(name: "E Major Scale", scaleType: .major, scaleAcc: .sharp, accCount: 4, startSound: Sound(tone: .E))
    static let BMaj = Scale(name: "B Major Scale", scaleType: .major, scaleAcc: .sharp, accCount: 5, startSound: Sound(tone: .B))
    static let FSharpMaj = Scale(name: "F Sharp Major Scale", scaleType: .major, scaleAcc: .sharp, accCount: 6, startSound: Sound(tone: .F))
    static let CSharpMaj = Scale(name: "C Sharp Scale", scaleType: .major, scaleAcc: .sharp, accCount: 7, startSound: Sound(tone: .C, accidental: .sharp))
    
}

