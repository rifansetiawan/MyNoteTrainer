//
//  SightReadingParentView.swift
//  MyNoteTrainer
//
//  Created by Widya Limarto on 23/08/22.
//

import SwiftUI

struct SightReadingParentView: View {
    var quiz: SRQuizModel
    @State var notesBlock: [[Int]]
    @State var tapIndicatorState: TapIndicatorState = .neutral
    
    @StateObject var tapIndicatorVM: TapIndicatorViewModel = TapIndicatorViewModel()
    var body: some View {
        ZStack(alignment: .top){
            ZStack(alignment: .top){
                SightReadingView(quiz: quiz,
                                 notes: quiz.song,
                                 bpmOptions: quiz.bpmOptions,
                                 notesBlock: SRHelper.generateBlock(offsetBeat: 1, notes: quiz.song),
                                 tapIndicatorVM: tapIndicatorVM
                )
                
                HStack{
                    ZStack(alignment: .trailing){

                        Rectangle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.bgColor.opacity(0.3), tapIndicatorState.color]), startPoint: .leading, endPoint: .trailing))
                            .opacity(0.5)

                        Rectangle()
                            .frame(width: 5, height: 100)
                            .foregroundColor(tapIndicatorState.color)
                        
                    }.frame(width: 80, height: 100, alignment: .trailing)
    //                            .background(.green)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding(.leading, 209)
                .offset(x: 0, y: -15)
            }
            
            
            
        }
        .onChange(of: tapIndicatorVM.tapIndicatorState, perform: {i in
            self.tapIndicatorState = i
        })
        
        
    }
}

struct SightReadingParentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SightReadingParentView(quiz: SRQuizModel.quizes[0], notesBlock: SRHelper.generateBlock(offsetBeat: 1, notes: SRQuizModel.quizes[0].song))
                .previewInterfaceOrientation(.landscapeLeft)
        }
        .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
