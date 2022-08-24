//
//  ScaleQuizModel.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 22/08/22.
//

import Foundation
struct ScaleQuizModel  {
    var scale: Scale
    
    static var scaleQuizes : [ScaleQuizModel] = [
        ScaleQuizModel(scale: .CMaj),
        ScaleQuizModel(scale: .DMaj),
        ScaleQuizModel(scale: .AMaj),
        ScaleQuizModel(scale: .BMaj),
        ScaleQuizModel(scale: .GMaj),
        ScaleQuizModel(scale: .EMaj)
    ]
    
}

struct ScaleQuizButtonModel {
    var name: String
    var scale: Scale
    
    static var scaleQuizButtons : [ScaleQuizButtonModel] = [
        ScaleQuizButtonModel(name: "C", scale: .CMaj),
        ScaleQuizButtonModel(name: "D", scale: .DMaj),
        ScaleQuizButtonModel(name: "E", scale: .EMaj),
        ScaleQuizButtonModel(name: "G", scale: .GMaj),
        ScaleQuizButtonModel(name: "A", scale: .AMaj),
        ScaleQuizButtonModel(name: "B", scale: .BMaj)
    ]
    
}

