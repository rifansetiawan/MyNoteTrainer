//
//  PracticeView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 18/08/22.
//

import SwiftUI

struct PracticeView: View {
    var songs: [SRQuizModel] = SRQuizModel.quizes
    @State var selectedQuiz: Int?
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.bgColor
                .ignoresSafeArea()
                
                VStack(spacing: 15){
                    ForEach(songs, id:\.id) { quiz in
                        
                        NavigationLink(
                            tag: quiz.id,
                            selection: $selectedQuiz,
                            destination: {
                                SightReadingParentView(
                                    quiz: quiz,
                                    notesBlock: SRHelper.generateBlock(offsetBeat: 1, notes: quiz.song)
                                )
                            }
                        ) {
                            ZStack{
                                Rectangle()
                                    .frame(width: 345, height: 105)
                                    .foregroundColor(Color.white)
                                HStack{
                                    Image(quiz.image)
                                        .resizable()
                                        .frame(width: 105, height: 105)
                    
                                    VStack{
                                        Text(quiz.title)
                                            .font(.system(size: 16, weight: .semibold))
                                            .frame(width: 145, height: 16, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        HStack{
                                            Circle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(Color.green)
                                            Text("Beginner")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color.gray)
                                            
                                        }.frame(width: 145, height: 16, alignment: .leading)
                                        
                                        HStack{
                                            Image(systemName: "book")
                                                .foregroundColor(Color.gray)
                                            Text("\(quiz.bpmOptions.count) Lessons")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color.gray)
                                        }.frame(width: 145, height: 16, alignment: .leading)
                                    }
                                }
                                .frame(width: 345, height: 105, alignment: .leading)
                                
                            }
                        }
                    }
                    
                    
                    
                }
            }
        }
    }
}
