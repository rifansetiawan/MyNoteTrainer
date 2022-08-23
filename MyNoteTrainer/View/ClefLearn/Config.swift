//
//  Config.swift
//  quint
//
//  Created by Widya Limarto on 13/05/22.
//

import Foundation

class Config {
    
    static var OFFSET_BPM = 3
    static var BLOCK_WIDTH = 50
    
    static var coachmarkData : [CoachmarkType : [Coachmark]] = [
        .tap : [
            Coachmark(description: "The box indicates the note being played. Tap when the note is exaclty in the box."),
            Coachmark(description: "The dot represents the beat, have sounds like a metronome."),
            //            Coachmark(description: "This information contains a brief description of the material, to understand the material further, please click information."),
            Coachmark(description: "The red box indicates that you press the wrong note or rest note."),
            Coachmark(description: "The green box indicates that you already press correct note. ")
        ]
    ]
    
}

