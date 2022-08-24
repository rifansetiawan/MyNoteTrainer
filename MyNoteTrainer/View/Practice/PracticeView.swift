//
//  PracticeView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 18/08/22.
//

import SwiftUI

struct PracticeView: View {
    var songs: SRSongs = SRSongs()
    @State var bpm : Int = 120
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.bgColor
                .ignoresSafeArea()
                
                VStack(spacing: 15){
                    
                    NavigationLink(destination: SightReadingParentView(
//                        vm: SRPlayerManager(notes: songs.twinkle, bpm: 120, offsetBpm: 1),
                        notes: songs.twinkle,
                        bpm: $bpm,
                        notesBlock: SRHelper.generateBlock(offsetBeat: 1, notes: songs.twinkle))){
                        ZStack{
                            Rectangle()
                                .frame(width: 345, height: 105)
                                .foregroundColor(Color.white)
                            HStack{
                                Image("Twinkle Twinkle")
                                    .resizable()
                                    .frame(width: 105, height: 105)
                
                                VStack{
                                    Text("Twinkle Twinkle")
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
                                        Text("4 Lessons")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(Color.gray)
                                    }.frame(width: 145, height: 16, alignment: .leading)
                                }
                            }
                            .frame(width: 345, height: 105, alignment: .leading)
                            
                        }
                    }
                    
                    Button(action: {}, label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 345, height: 105)
                                .foregroundColor(Color.white)
                            HStack{
                                Image("Jingle Bells")
                                    .resizable()
                                    .frame(width: 105, height: 105)
                                
                                VStack{
                                    Text("Jingle Bells")
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
                                        Text("4 Lessons")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(Color.gray)
                                    }.frame(width: 145, height: 16, alignment: .leading)
                                }
                            }
                            .frame(width: 345, height: 105, alignment: .leading)
                            
                        }
                    })
                    
                    Button(action: {}, label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 345, height: 105)
                                .foregroundColor(Color.white)
                            HStack{
                                Image("Symphony")
                                    .resizable()
                                    .frame(width: 105, height: 105)
                                
                                VStack{
                                    Text("Symphony")
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
                                        Text("4 Lessons")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(Color.gray)
                                    }.frame(width: 145, height: 16, alignment: .leading)
                                }
                            }
                            .frame(width: 345, height: 105, alignment: .leading)
                            
                        }
                    })
                }
            }
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
