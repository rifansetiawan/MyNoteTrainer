//
//  MNLearnContentView.swift
//  MyNoteTrainer
//
//  Created by Widya Limarto on 04/09/22.
//

import SwiftUI

struct MNLearnContentView: View {
    
    @ObservedObject var vm : MusicalNoteQuizPlayerManager
    var musicalNote: [NoteType]
    @Binding var progressIndex : Int
    var intervals : [Float]
    
    var beat : Int = 8
    @State var currentNoteIndex : Int = 0
    @State var currentIntervalIndex: Int = 0
    @State var rectColor: [Color] = []
    @State var currentBeat: Int = -1
    
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 20) {
                
                Image(musicalNote[currentNoteIndex].image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            .cornerRadius(15)
                
                Text("\(musicalNote[currentNoteIndex].name)")
                    .font(.system(size: 35, weight: .bold))
                
            }
            
            ZStack {
                HStack(spacing:0){
                    ForEach((1...8), id: \.self) {_ in
                        Rectangle()
                            .fill(.white)
                            .frame(width: 45, height: 100)
                            .border(.gray, width: 1)
                    }
                }
                HStack(spacing:0) {
                    ForEach(rectColor, id:\.self) { i in
                        Rectangle()
                            .fill(i)
                            .frame(width: 45, height: 100)
                            .border(.gray, width: 1)
                    }
    
                }.frame(width: 360, height: 100, alignment: .leading)
                
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                
                    Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
                    
                    Capsule().fill(Color.purple).frame(width: geometry.size.width * CGFloat(vm.playbackProgress), height: 8)
                    .gesture(DragGesture()
                        .onChanged({ (value) in
                            
    //                        let x = value.location.x
    //
    //                        self.width = x
                            
                        }).onEnded({ (value) in
                            
    //                        let x = value.location.x
    //
    //                        let screen = UIScreen.main.bounds.width - 30
    //
    //                        let percent = x / screen
    //
    //                        self.player.currentTime = Double(percent) * self.player.duration
                        }))
                }
                
            }
            HStack{
                Button(action: {
                    
                    withAnimation(.easeInOut(duration: 0.5)){
                        if self.progressIndex > 0{
                            self.progressIndex -= 1
                        }
                        
                    }

                }) {
            
                    Image("back").font(.title)
                    
                }
                .disabled(self.progressIndex == 0)
                
                Button(action: {
                        self.rectColor = []
                        self.currentNoteIndex = 0
                        self.currentIntervalIndex = 0
                        self.vm.play()
                    
                    
                    
                }) {
            
                    Image("play").font(.title)
                    
                }.disabled(self.vm.isPlaying)
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)){
                        self.progressIndex += 1
                    }
                }) {
                    Image("next").font(.title)
                }
                .disabled(self.progressIndex == 2)
            }
            
        }
        .onDisappear{
            self.vm.stop()
        }
        
        .onChange(of: progressIndex, perform: { i in
            self.rectColor = []
            self.vm.stop()
            
        })
        .onChange(of: vm.playbackProgress, perform: {i in
            print(intervals)
            if (currentIntervalIndex+1 < intervals.count && i > intervals[currentIntervalIndex+1]) {
                currentNoteIndex = currentNoteIndex == 1 ? 0 : 1
                currentIntervalIndex += 1
            }
            
            let currentBeat = Int(i / ( 1.0/Float(beat) ) )
            if( i > Float(1.0/Double(beat) * Double(currentNoteIndex)) )  {
                self.currentBeat = currentBeat
            }
                
        })
        .onChange(of: currentBeat, perform: { i in
            if(currentBeat > -1) {
                self.rectColor.append(musicalNote[currentNoteIndex].isRest ? Color.brownColor : Color.primaryColor)
            }
        })
    }
}

//struct MNLearnContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MNLearnContentView()
//    }
//}
