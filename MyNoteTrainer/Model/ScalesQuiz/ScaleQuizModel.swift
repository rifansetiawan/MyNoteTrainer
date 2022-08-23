//
//  ScaleQuizModel.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 22/08/22.
//

import Foundation
struct QuizModel  {
    var img : String?
    var answer : [String]
    var correct : Int?
}
var scaleQuiz : [QuizModel] = [
    QuizModel(img: "kunciG", answer: ["A","D","E","G"], correct: 3),
    QuizModel(img: "kunciG", answer: ["B","C","B","F"], correct: 2),
    QuizModel(img: "kunciG", answer: ["C","E","B","A"], correct: 2),
    QuizModel(img: "kunciG", answer: ["C","E","B","A"], correct: 2)
]
