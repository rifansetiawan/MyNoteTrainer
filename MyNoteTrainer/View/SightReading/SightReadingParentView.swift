//
//  SightReadingParentView.swift
//  MyNoteTrainer
//
//  Created by Widya Limarto on 23/08/22.
//

import SwiftUI

struct SightReadingParentView: View {
    @State var notes: [Note]
    @Binding var bpm : Int
    @State var notesBlock: [[Int]]
    @State var tapIndicatorState: TapIndicatorState = .neutral
    
    @StateObject var tapIndicatorVM: TapIndicatorViewModel = TapIndicatorViewModel()
    var body: some View {
        ZStack(alignment: .top){
            SightReadingView(notes: notes,
                             bpm: $bpm,
                             notesBlock: notesBlock,
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
            
            
        }.onChange(of: tapIndicatorVM.tapIndicatorState, perform: {i in
            self.tapIndicatorState = i
        })
        
    }
}

struct SightReadingParentView_Previews: PreviewProvider {
    static var previews: some View {
        SightReadingParentView(notes: [], bpm: .constant(60), notesBlock: [[]])
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
