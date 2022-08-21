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


struct Note: Equatable {
    
    var name: String
    var image: String
    var beat: Beat
    var isRest: Bool = false
    var level: Double = 3.0

    
    static let fullNote = Note(name: "Full", image: "wholeNote", beat: .full)
    static let halfNote = Note(name: "Half", image: "halfNote", beat: .half)
    static let quarterNote = Note(name: "Quarter", image: "quarterNote", beat: .quarter)
    static let eighthNote = Note(name: "Eighth", image: "eightNote", beat: .eighth)
    static let fullRest = Note(name: "FullRest", image: "fullRest", beat: .full, isRest: true)
    static let halfRest = Note(name: "HalfRest", image: "halfRest", beat: .half, isRest: true)
    static let quarterRest = Note(name: "QuarterRest", image: "quarterRest", beat: .quarter, isRest: true)
    static let eighthRest = Note(name: "EightRest", image: "eighthRest", beat: .eighth, isRest: true)
    
    
    
}
