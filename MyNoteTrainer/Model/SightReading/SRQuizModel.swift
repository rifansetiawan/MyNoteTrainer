//
//  SRQuizModel.swift
//  MyNoteTrainer
//
//  Created by Widya Limarto on 24/08/22.
//

import Foundation


struct SRQuizModel {
    var id: Int
    var title: String
    var image: String
    var song: [Note]
    var scale: Scale
    var bpmOptions: [Int]
    
    static let quizes: [SRQuizModel] = [
        SRQuizModel(id: 1, title: "Twinkle Twinkle", image: "Twinkle Twinkle", song: SRSongs.twinkle, scale: .CMaj, bpmOptions: [60, 120, 150]),
        SRQuizModel(id: 2, title: "菊花台 by Jaychou", image: "Jingle Bells", song: SRSongs.jaychou, scale: .CMaj, bpmOptions: [60, 120, 150])
    ]

}


