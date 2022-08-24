//
//  MusicalNoteQuiz.swift
//  MyNoteTrainer
//
//  Created by Mikhael Budi Mulya Marpaung on 23/08/22.
//

import SwiftUI
import AVKit
import Combine


struct MusicalNoteQuiz: View {
    var maxDigits: Int = 4
    var label = "Enter One Time Password"
        
    @State var pin: String = ""
    @State var showPin = false
    @State var isDisabled = false
    
    @State private var playAudio: Bool = false
    @State private var audioLength: TimeInterval = 0
    @State private var currentTime: TimeInterval = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ZStack{
                        ledgerLine()
                        pinDots
                        
//                        HStack{
//                            ForEach((1...4).reversed(), id: \.self) {_ in
//                                Rectangle()
//                                    .frame(width: 77, height: 105)
//                                    .foregroundColor(.primaryColor.opacity(0.4))
//                            }
//                        }
                    }
                    
                    Button {
                        self.playAudio.toggle()
                    } label: {
                        Image(playAudio ? "pauseButton" : "playButton")
                            .resizable()
                            .frame(width: 85, height: 85)
                    }
                    
                    
                    
                   
                }
            }
            .navigationTitle("Music Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        playAudio.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 27, height: 27)
                    }
                }
            }
        }
    }
    private var pinDots: some View {
            HStack {
                Spacer()
                ForEach(0..<self.maxDigits) { index in
                    Rectangle()
                        .frame(width: 77, height: 105)
                        .foregroundColor(.primaryColor.opacity(0.4))
                    Spacer()
                }
            }
        }
}
struct MusicalNoteQuiz_Previews: PreviewProvider {
    static var previews: some View {
        MusicalNoteQuiz()
    }
}

struct ledgerLine: View {
    var body: some View {
        VStack(alignment: .center, spacing: 25){
            Rectangle()
                .frame(width: .infinity, height: 4)
                .foregroundColor(.gray)
            Rectangle()
                .frame(width: .infinity, height: 4)
                .foregroundColor(.gray)
            Rectangle()
                .frame(width: .infinity, height: 4)
                .foregroundColor(.gray)
            Rectangle()
                .frame(width: .infinity, height: 4)
                .foregroundColor(.gray)
            Rectangle()
                .frame(width: .infinity, height: 4)
                .foregroundColor(.gray)
        }
    }
}
