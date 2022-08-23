//
//  SightReadingView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 19/08/22.
//

import SwiftUI

struct SightReadingView: View {
    @StateObject var conductor = InstrumentEXSConductor()
    @StateObject var vm = SRPlayerManager(notes: [
        Note(noteType: .quarterNote, sound: Sound(tone: .C)), //0
        Note(noteType: .quarterNote, sound: Sound(tone: .D)),
        Note(noteType: .quarterNote, sound: Sound(tone: .E)),
        Note(noteType: .quarterNote, sound: Sound(tone: .F)),
        Note(noteType: .quarterNote, sound: Sound(tone: .G)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .A)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .B)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
    ], bpm: 60, offsetBpm: 1)
    var notes: [Note] = [
        Note(noteType: .quarterNote, sound: Sound(tone: .C)), //0
        Note(noteType: .quarterNote, sound: Sound(tone: .D)),
        Note(noteType: .quarterNote, sound: Sound(tone: .E)),
        Note(noteType: .quarterNote, sound: Sound(tone: .F)),
        Note(noteType: .quarterNote, sound: Sound(tone: .G)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .A)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .B)),
//        Note(noteType: .quarterNote, sound: Sound(tone: .C, octave: 5)),
    ]
    @State var onTap = false
    
    @State var tapIndicatorState: TapIndicatorState = .neutral {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if tapIndicatorState != .neutral {
                    tapIndicatorState = .neutral
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.bgColor
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    Button(action: { vm.start() } ) {
                        Text("Start")
                            .font(.system(size: 22, weight: .bold))
                        Text("\(vm.playingTimestamp)  \(vm.playingIndex)")
                    }
                    Spacer()
                    
                    Text("Twinkle Twinkle")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Spacer()
                }
                .padding()
                
                SRParanadaView(vm: vm, tapIndicatorState: tapIndicatorState)
                
                //            Text("\(conductor.noteNumber ?? -1)")
                
                InstrumentEXSView(conductor: conductor)
                    .frame(maxWidth: .infinity, maxHeight: 175)
                //            PianoView(keyInfo: $keyInfo)
            }
            
            .onAppear{
                AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
                UINavigationController.attemptRotationToDeviceOrientation()
            }
            .onDisappear {
                DispatchQueue.main.async {
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
                }
            }
        }
        .onReceive(conductor.$noteNumber, perform: { i in
            print(i, vm.playingTimestamp)
            if(vm.isPlaying) {
                onTapNote(noteNumber: i!, timestamp: vm.playingTimestamp)
            }
            
        })
        
    }
//
    func onTapNote(noteNumber: Int8, timestamp: TimeInterval) {
        // check apakah notenumber dan timing nya tepat atau tidak
       // kalo -1, cek timing index selanjutnya
        // kalo 0, cek timing current index dan next index (jika ada) timing apakah salah satu ada yang cocok
        // kalo 1, cek timing index 1 dan index 2 (jika next index nya ada)
        // check next index timing
        let currentIndex = vm.playingIndex
        let nextIndex = currentIndex + 1 // -1 -> 0
        let nextIndexTiming = vm.noteTiming[nextIndex] + vm.startTime
        let currentIndexTiming = currentIndex > -1 ? vm.noteTiming[currentIndex] + vm.startTime : -1
        
        let offsetTiming = 0.25
        
        if(abs(timestamp - nextIndexTiming) < offsetTiming) {
            tapIndicatorState = .green
        } else if (abs(timestamp - currentIndexTiming) < offsetTiming) {
            tapIndicatorState = .green
        } else {
            tapIndicatorState = .red
        }
        
        
        // set warna tap indicator di state
        // simpan di collections (index note : hasilnya)
        // hasil dihitung berdasarkan brp jumlah note yang benar dan timing yang tepat *100
        
    }
}

struct SightReadingView_Previews: PreviewProvider {
    static var previews: some View {
        SightReadingView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
