//
//  SightReadingView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 19/08/22.
//

import SwiftUI

struct SightReadingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var quiz: SRQuizModel
    var notes: [Note]
    var bpmOptions: [Int] = [60,120,180]
    
    
    var notesBlock : [[Int]]
    var tapIndicatorVM: TapIndicatorViewModel
    
    @State var isPlaying: Bool = false
    @State var noteNumber: Int8 = -1
    @State var startTime: TimeInterval = -1
    @State var endTime: TimeInterval = -1
    @State var playingTimestamp: TimeInterval = -1
    @State var playingIndex: Int = -1
    @State var bpmIndex: Int = 0
    
    @State var noteInterval: [TimeInterval]?
    @State var noteTiming: [TimeInterval]?
    
    @State var results: [Int:Bool] = [:]
    
    @State var percentage: Int = -1
    
    var body: some View {
        ZStack {
            Color.bgColor
                .ignoresSafeArea()
            
            if(noteInterval != nil && noteTiming != nil) {
                VStack(spacing: 0){
                    ZStack{
                        SRParanadaView(
                            vm: SRPlayerManager(notes: notes, bpm: bpmOptions[bpmIndex], offsetBpm: 1, noteInterval: self.noteInterval!, noteTiming : self.noteTiming!),
                            isPlaying: $isPlaying,
                            notes: notes,
                            notesBlock: notesBlock,
                            startTime: $startTime,
                            endTime: $endTime,
                            playingTimestamp: $playingTimestamp,
                            playingIndex: $playingIndex,
                            scale: quiz.scale
                        )
                    }
                    InstrumentEXSView(onNoteOn: { i in
                        self.onTapNote(noteNumber: i, timestamp: self.playingTimestamp)
                       
                    })
                        .frame(maxWidth: .infinity, maxHeight: 175)
                        .padding(.horizontal, 30)
                }
            }
            
            if (!self.isPlaying && self.percentage == -1) {
                VStack {
                    Spacer()
                    VStack {
                        HStack{
                            Spacer()
                            Button(action: {
                                isPlaying = true
                                
                            }, label: {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                .background(Color.primaryColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(80)
                                    .shadow(color: .black50Color.opacity(0.3), radius: 5, x: 8, y: 5)

                            })
                            Spacer()
                        }
                        .padding(.vertical, 15)
                            .background(Color.grayColor.opacity(0.8))
                    }
                    .ignoresSafeArea()
                    Spacer()
                }
                .background(Color.black50Color.opacity(0.01))
            }
            
            if (!self.isPlaying && self.percentage != -1) {
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        VStack{
                            VStack{
                                ZStack{
                                    Image("backpop")
                                    ZStack {
                                        
                                        Rectangle()
                                            .fill(LinearGradient(colors: [.secondaryColor, .primaryColor], startPoint: .top, endPoint: .bottom))
//                                            .background(Color.secondaryColor)
                                            
                                            .frame(width: 120, height: 120, alignment: .center)
                                            .cornerRadius(180)
                                            .opacity(0.8)
                                        
                                        HStack(alignment: .bottom, spacing: 0){
                                            Text("\(percentage)")
                                                .font(.system(size: 50).bold())
                                                .foregroundColor(.white)
                                            Text("%")
                                                .font(.system(size: 30).bold())
                                                .foregroundColor(.white)
                                        }
                                        
//                                            .background(shadow(color: .grayColor, radius: 10, x: 2, y: 2))
                                    }
                                    
                                }
                                HStack {
                                    Text(percentage < 70 ? "Oh no.." : "Awesome")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                
                                HStack(alignment: .center){
                                    
                                    Text(percentage < 70 ? "Sorry you haven't finished your sight reading well, let's try again!" : "You have done your sight reading well, let's try other song!")
                                        .foregroundColor(Color.white)
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(15)
                                }
                                
                            }
                            .frame(width: 350)
                            HStack{
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Text("Back to home").frame(width: 300, height: 50, alignment: .center).background(.white).foregroundColor(Color.black).cornerRadius(30).font(.body.bold())
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(Color.primaryColor, lineWidth: 4)
                                        )

                                })
                                Spacer()
                                Button(action: {
                                    isPlaying = true
                                }, label: {
                                    Text("Try Again").frame(width: 300, height: 50, alignment: .center).background(Color.primaryColor).foregroundColor(.blackColor).cornerRadius(30)
                                        .font(.body.bold())
                                })
                            }
                            .padding(.horizontal, 55)
                        }
                        Spacer()
                    }
                    Spacer()
                }.background(Color.blackColor.opacity(0.65))
            }
        }
        .onAppear{
            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
            
//            ===
            
            self.setupIntervalandTiming()
        }
        .onDisappear {
            DispatchQueue.main.async {
                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                UINavigationController.attemptRotationToDeviceOrientation()
            }
        }
        .onChange(of: bpmIndex, perform: { i in
            self.setupIntervalandTiming()
        })
        .onChange(of: isPlaying, perform: { i in
            if (!i && endTime != -1) {
                getResultPercentage()
            } else if (i) {
                percentage = -1
            }
        })
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker("", selection: $bpmIndex) {
                                ForEach(bpmOptions, id: \.self) { i in
                                    Text("\(i)")
                                }
                            }
                            .pickerStyle(.menu)
            }
        }
        .navigationTitle(quiz.title)
        
    }
    
    func setupIntervalandTiming() {
        self.noteInterval = SRHelper.convertBeatToTimeInterval(notes: notes, bpm: self.bpmOptions[bpmIndex], offsetBpm: 1)
        self.noteTiming = SRHelper.countNoteTiming(noteInterval: noteInterval!)
    }
    
    func getResultPercentage()  {
        
        let filtered = notes.filter{ $0.noteType.isRest != true }
        print(results, results.count, filtered.count)
        self.percentage = results.count * 100 / filtered.count
       
    }
    
    func saveResult(index: Int, result: Bool) {
        self.results[index] = result
    }
//
    func onTapNote(noteNumber: Int8, timestamp: TimeInterval) {
        print(timestamp, startTime, endTime, playingTimestamp, playingIndex)
        // check apakah notenumber dan timing nya tepat atau tidak
       // kalo -1, cek timing index selanjutnya
        // kalo 0, cek timing current index dan next index (jika ada) timing apakah salah satu ada yang cocok
        // kalo 1, cek timing index 1 dan index 2 (jika next index nya ada)
        // check next index timing
    
        let currentIndex = self.playingIndex
//
        if(currentIndex >= notes.count-1) {
            tapIndicatorVM.changeState(state: .red)
            return
        }
        let nextIndex = currentIndex + 1 // -1 -> 0
        let nextIndexTiming = self.noteTiming![nextIndex] + self.startTime
        
        let currentIndexTiming = currentIndex > -1 ? self.noteTiming![currentIndex] + self.startTime : -1
//
        let offsetTiming = 0.25
//
        if(abs(timestamp - nextIndexTiming) < offsetTiming
           && (noteNumber == notes[nextIndex].sound.key && !notes[nextIndex].noteType.isRest)
        ) {
            tapIndicatorVM.changeState(state: .green)
            saveResult(index: nextIndex, result: true)
            
        } else if (abs(timestamp - currentIndexTiming) < offsetTiming
                   && (noteNumber == notes[currentIndex].sound.key && !notes[currentIndex].noteType.isRest)
        ) {
            tapIndicatorVM.changeState(state: .green)
            saveResult(index: currentIndex, result: true)
        } else {
            tapIndicatorVM.changeState(state: .red)
        }
        
        
        // set warna tap indicator di state
        // simpan di collections (index note : hasilnya)
        // hasil dihitung berdasarkan brp jumlah note yang benar dan timing yang tepat *100
        
    }
}

//struct SightReadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SightReadingView( vm: SRPlayerManager(notes: [], offsetBpm: 1), notes: [], notesBlock: SRHelper.generateBlock(offsetBeat: 1, notes: []))
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
