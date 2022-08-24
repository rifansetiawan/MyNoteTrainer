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
        MusicalNoteQuizModel(id: 1, answer: [.fullNote, .halfNote, .halfRest, .quarterNote], song: "Quiz1"),
        MusicalNoteQuizModel(id: 2, answer: [.halfNote, .quarterNote, .halfNote, .quarterNote], song: "Quiz2"),
        MusicalNoteQuizModel(id: 3, answer: [.quarterNote, .quarterRest, .quarterNote, .quarterNote], song: "Quiz3"),
    ]
}
