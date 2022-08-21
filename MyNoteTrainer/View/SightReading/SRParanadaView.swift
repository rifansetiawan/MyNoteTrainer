//
//  ParanadaView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 20/08/22.
//

import SwiftUI

struct SRParanadaView: View {
//    var notes: [Note] = [.quarterNote, .halfNote, .eighthNote, .quarterNote, .quarterNote, .quarterNote, .quarterNote]
//    var notesBlock = SRHelper.generateBlock(offsetBpm: 1, notes: [.quarterNote, .halfNote, .eighthNote, .quarterNote, .quarterNote, .quarterNote, .quarterNote])
    var notes: [Note] = []
    var notesBlock: [[Int]] = []
    
    var body: some View {
        ZStack(alignment: .trailing){
            VStack(spacing: 18){
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                .foregroundColor(Color.grayColor)
            }
            HStack {
                Image("kunciG")
                    .resizable()
                .frame(width: 127, height: 127)
                
                ZStack(alignment: .trailing){
                    
                    Rectangle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.primaryColor)
                        .opacity(0.5)
                    
                    Rectangle()
                        .frame(width: 5, height: 100)
                        .foregroundColor(Color.primaryColor)
                }
                Spacer()
            }
                HStack{
                    HStack(spacing: 0){
                        ForEach(Array(notesBlock.enumerated()), id: \.offset){ (i, block) in
                            HStack{
                                ZStack(alignment: .bottom){
                                    if(block.count > 1 && block[1] > 0) {
                                        Image(notes[block[1]-1].noteType.image)
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 35, height: 38, alignment: .bottom)
                                    }
                                    

                                }.frame(maxWidth: .infinity, maxHeight: .infinity)
    //                                .background(.green)
                                    .offset(x: -25, y: 0)
                                
                            }
                            .frame(maxWidth: 50, maxHeight: .infinity)
    //                        .background(.purple.opacity(0.5))
    //                        .border(.yellow)
                            
                            
                        }
                    }
    //                .background(Color.white)
                    .offset(x: 80, y: 0)
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 200, maxHeight: .infinity, alignment: .leading)
//             .background(Color.brownColor)
                .clipped()
            

            }
            .frame(maxWidth: .infinity, maxHeight: 200)
//            .background(Color.blue)
        }
        func countOffset() -> CGFloat {
            return CGFloat( notesBlock.count * 50 * -1 )
    }
}

struct SRParanadaView_Previews: PreviewProvider {
    static var previews: some View {
        SRParanadaView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
