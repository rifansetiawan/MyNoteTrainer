//
//  MusicalNoteQuizModel.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 24/08/22.
//

import Foundation

struct MusicalNoteQuizModel {
    var id : Int
    var answer : [NoteType]
    var song: String
    
    static let quizes : [MusicalNoteQuizModel] = [
        MusicalNoteQuizModel(id: 1, answer: [.quarterNote, .quarterRest, .halfNote, .quarterNote], song: "beat_audio_1"),
        MusicalNoteQuizModel(id: 2, answer: [.fullNote, .quarterRest, .quarterNote, .quarterRest], song: "beat_audio_2"),
        MusicalNoteQuizModel(id: 3, answer: [.fullNote, .halfNote, .halfRest, .halfRest], song: "beat_audio_3"),
    ]
}
