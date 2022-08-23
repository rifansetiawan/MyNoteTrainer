//
//  SightReadingView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 19/08/22.
//

import SwiftUI

struct SightReadingView: View {
//    @StateObject var conductor: InstrumentEXSConductor
//    @StateObject var vm : SRPlayerManager
//    SRPlayerManager(notes: [
//        Note(noteType: .quarterNote, sound: Sound(tone: .C)), //0
//        Note(noteType: .quarterNote, sound: Sound(tone: .D)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .E)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .F)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .G)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .A)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .B)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
//    ], bpm: 60, offsetBpm: 1)
    
   
    var notes: [Note]
    @Binding var bpm: Int
    var bpmOptions: [Int] = [60,120,180]
    
    
    var notesBlock : [[Int]]
    var tapIndicatorVM: TapIndicatorViewModel
    
//    init(notes: [Note]) {
//        self.notes = notes
//        self.conductor = InstrumentEXSConductor()
//        self.vm = SRPlayerManager(notes: notes, bpm: 60, offsetBpm: 1)
//        self.notesBlock = SRHelper.generateBlock(offsetBeat: 1, notes: notes)
//    }
    
    @State var isPlaying: Bool = false
    @State var noteNumber: Int8 = -1
    @State var startTime: TimeInterval = -1
    @State var endTime: TimeInterval = -1
    @State var playingTimestamp: TimeInterval = -1
    @State var playingIndex: Int = -1
    
    @State var noteInterval: [TimeInterval]?
    @State var noteTiming: [TimeInterval]?
    
    var body: some View {
        ZStack {
            Color.bgColor
                .ignoresSafeArea()
            
            if(noteInterval != nil && noteTiming != nil) {
                VStack(spacing: 0){
                    ZStack{
                        SRParanadaView(
                            vm: SRPlayerManager(notes: notes, bpm: bpm, offsetBpm: 1, noteInterval: self.noteInterval!, noteTiming : self.noteTiming!),
                            isPlaying: $isPlaying,
                            notes: notes,
                            notesBlock: notesBlock,
                            startTime: $startTime,
                            endTime: $endTime,
                            playingTimestamp: $playingTimestamp,
                            playingIndex: $playingIndex
                        )
                        
                        
                    }
                    
                    

                    InstrumentEXSView(onNoteOn: { i in
                        self.onTapNote(noteNumber: i, timestamp: self.playingTimestamp)
    //                        print(i, vm.playingTimestamp)
    //                        if(vm.isPlaying) {
        //                        onTapNote(noteNumber: i, timestamp: vm.playingTimestamp)
    //                        }
    //                    guard let i = i else {return}
                       
                    })
                        .frame(maxWidth: .infinity, maxHeight: 175)
                    //            PianoView(keyInfo: $keyInfo)
                }
            }
            
            
            if (!self.isPlaying) {
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
        .onChange(of: bpm, perform: { i in
            self.setupIntervalandTiming()
        })
//        .onChange(of: tapIndicatorVM.tapIndicatorState, perform: { i in
//            self.tapIndicatorState = tapIndicatorVM.tapIndicatorState
//        })
//        .onReceive(conductor.$noteNumber, perform: { i in
//            guard let i = i else {return}
//            print(i, vm.playingTimestamp)
//            if(vm.isPlaying) {
//                onTapNote(noteNumber: i, timestamp: vm.playingTimestamp)
//            }
            
//        })
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker("", selection: $bpm) {
                                ForEach(bpmOptions, id: \.self) { i in
                                    Text("\(i)")
                                }
                            }
                            .pickerStyle(.menu)
            }
        }
        .navigationTitle("Twinkle Twinkle")
        
    }
    
    func setupIntervalandTiming() {
        self.noteInterval = SRHelper.convertBeatToTimeInterval(notes: notes, bpm: self.bpm, offsetBpm: 1)
        self.noteTiming = SRHelper.countNoteTiming(noteInterval: noteInterval!)
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
        if(abs(timestamp - nextIndexTiming) < offsetTiming && (noteNumber == notes[nextIndex].sound.key)) {
            tapIndicatorVM.changeState(state: .green)
            
        } else if (abs(timestamp - currentIndexTiming) < offsetTiming && (noteNumber == notes[currentIndex].sound.key)) {
            tapIndicatorVM.changeState(state: .green)
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
