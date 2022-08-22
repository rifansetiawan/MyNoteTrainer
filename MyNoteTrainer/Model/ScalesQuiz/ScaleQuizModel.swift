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
    QuizModel(img: "kunciG", answer: ["A","D","E","G"], correct: 4),
    QuizModel(img: "kunciG", answer: ["A","D","E","G"], correct: 4)
]
