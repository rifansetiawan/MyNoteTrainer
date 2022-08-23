//
//  GarisParanadaView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 21/08/22.
//

import SwiftUI

struct ScalesParanadaView: View {
    
    //wait
    var noteNumber: Int8
    
    var scale: Scale
    
    var offsetParanada: Double = 18
    // naik setengha kan? hmmm
    
    var body: some View {
        ZStack(alignment: .trailing){
            VStack(spacing: 15){
                ForEach((1...5).reversed(), id: \.self) {_ in
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                        .foregroundColor(Color.grayColor)
                }
                
            }
            HStack {
                Image("kunciG")
                
                HStack(spacing: -5) {
                    
                    ForEach(scale.accTones, id:\.self) { acd in
                        ZStack{
                            VStack{
                                Image(scale.scaleAcc.image)
                                    .offset(x: 0, y: 6)
                            }
//                                                        .background(acd.rawValue == conductor.noteNumber )
                            .offset(x: 0, y: acd.accidentalPosition * offsetParanada)
                            
                        }
                        .frame(maxHeight: 71, alignment: .bottom)
                    }
                }
                
                HStack(spacing: 20){
                    ForEach(Array(scale.notes.enumerated()), id: \.offset ) { (idx, note) in
                        ZStack{
                            ZStack(alignment: .bottom){
                                Image("\(note.noteType.image)\(self.noteNumber == note.sound.key ? "Blue" : "")")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 50, height: 60, alignment: .bottom)
                                //                                                                        .background(.yellow)
                                if(idx < scale.notes.count-1 ){
                                    VStack{
                                        Text("\(scale.scaleType.interval[idx] == 2 ? "1" : "1/2")")
                                            .font(.caption.bold())
                                            .foregroundColor(.red)
                                        
                                    }
                                    
                                    .offset(x: 38, y: 15)
                                    
                                }
                                
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            //                            .background(.pink)
                            .offset(x: 0, y: note.sound.position * offsetParanada)
                            //naik satu nada -10,5
                            HStack(spacing: 0){
                                Text("\(note.sound.tone.rawValue)")
                                    .font(.title2.bold())
                                    .foregroundColor(self.noteNumber == note.sound.key ? .primaryColor : .blackColor)
                                if(note.sound.accidental != nil) {
                                    Image(note.sound.accidental!.image)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: 12, height: 30)
                                }
                                
                            }.offset(x: 0, y: 80)
                            
                        }
                        .frame(maxWidth: 50, maxHeight: .infinity)
                        //                        .background(.green)
                        
                    }
                    
                    .frame(maxHeight: 71)
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity, alignment: .leading)
                .clipped()
                //                .background(.blue)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
}

struct ScalesParanadaView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesParanadaView(noteNumber: 0, scale: Scale.AMaj)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
