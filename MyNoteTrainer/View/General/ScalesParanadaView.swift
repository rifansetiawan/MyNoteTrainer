//
//  GarisParanadaView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 21/08/22.
//

import SwiftUI

struct ScalesParanadaView: View {
    var notes: [Note] = [
        Note(noteType: .quarterNote, sound: Sound(tone: .C)),
        Note(noteType: .quarterNote, sound: Sound(tone: .D)),
        Note(noteType: .quarterNote, sound: Sound(tone: .E)),
        Note(noteType: .quarterNote, sound: Sound(tone: .F)),
        Note(noteType: .quarterNote, sound: Sound(tone: .G)),
        Note(noteType: .quarterNote, sound: Sound(tone: .A)),
        Note(noteType: .quarterNote, sound: Sound(tone: .B)),
        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
    ]
    
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
            
                HStack(spacing: 0) {
                    ZStack{
                        VStack{
                            Image("sharp")
                                .offset(x: 0, y: 6)
                        }
                        .offset(x: 0, y: -73.5)
//                        .background(.green)
                    }
                    .frame(maxHeight: 85, alignment: .bottom)
                    ZStack{
                        VStack{
                            Image("sharp")
                                .offset(x: 0, y: 6)
                        }
                        .offset(x: 0, y: -63)
//                        .background(.green)
                    }
                    .frame(maxHeight: 85, alignment: .bottom)
                }
                
    
                
                HStack(spacing: 20){
                    ForEach(notes, id: \.id) { note in
                        HStack{
                            ZStack(alignment: .bottom){
                                Image(note.noteType.image)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: 60, height: 70, alignment: .bottom)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//                            .background(.pink)
                            .offset(x: 0, y: note.sound.position * 21)
                            //naik satu nada -10,5
                            
                        }
                        .frame(maxWidth: 50, maxHeight: .infinity)

                    }
                    
                    .frame(maxHeight: 85)
                    
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
        ScalesParanadaView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
