//
//  GarisParanadaView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 21/08/22.
//

import SwiftUI

struct ScalesParanadaView: View {
    
    //wait
    @ObservedObject var conductor: InstrumentEXSConductor
    var notes: [Note] = [
        Note(noteType: .quarterNote, sound: Sound(tone: .C)),
        Note(noteType: .quarterNote, sound: Sound(tone: .D)),
        Note(noteType: .quarterNote, sound: Sound(tone: .E, accidental: .sharp)),
        Note(noteType: .quarterNote, sound: Sound(tone: .F, accidental: .sharp)),
        Note(noteType: .quarterNote, sound: Sound(tone: .G)),
        Note(noteType: .quarterNote, sound: Sound(tone: .A)),
        Note(noteType: .quarterNote, sound: Sound(tone: .B)),
        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
    ]
    
    
    // naik setengha kan? hmmm
    
    var body: some View {
        ZStack(alignment: .trailing){
            VStack(spacing: 15){
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
            
                HStack(spacing: 0) {
                    ZStack{
                        VStack{
                            Image("sharp")
                                .offset(x: 0, y: 6)
                        }
                        .offset(x: 0, y: -63)
//                        .background(.green)
                    }
                    .frame(maxHeight: 71, alignment: .bottom)
                    ZStack{
                        VStack{
                            Image("sharp")
                                .offset(x: 0, y: 6)
                        }
                        .offset(x: 0, y: -54)
//                        .background(.green)
                    }
                    .frame(maxHeight: 71, alignment: .bottom)
                }
                
    
                
                HStack(spacing: 20){
                    ForEach(notes, id: \.id) { note in
                        HStack{
                            ZStack(alignment: .bottom){
                                Image("\(note.noteType.image)\(conductor.noteNumber == note.sound.key ? "Blue" : "")")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: 50, height: 60, alignment: .bottom)
//                                        .background(conductor.noteNumber == note.sound.key ? .red : .clear)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//                            .background(.pink)
                            .offset(x: 0, y: note.sound.position * 18)
                            //naik satu nada -10,5
                            
                        }
                        .frame(maxWidth: 50, maxHeight: .infinity)

                    }
                    
                    .frame(maxHeight: 71)
                    
                }
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity, alignment: .leading)
                    .clipped()
            }
            
            

            }
            .frame(maxWidth: .infinity, maxHeight: 200)
        }
        
}

struct ScalesParanadaView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesParanadaView(conductor: InstrumentEXSConductor())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
