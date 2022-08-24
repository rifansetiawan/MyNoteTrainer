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
    
    static let quizes : [MusicalNoteQuizModel] = [
        MusicalNoteQuizModel(id: 1, answer: [.fullNote, .halfNote, .quarterNote, .eighthNote]),
        MusicalNoteQuizModel(id: 2, answer: [.fullNote, .halfNote, .fullRest, .fullRest]),
        MusicalNoteQuizModel(id: 3, answer: [.fullNote, .halfNote, .halfRest, .halfRest]),
    ]
}
