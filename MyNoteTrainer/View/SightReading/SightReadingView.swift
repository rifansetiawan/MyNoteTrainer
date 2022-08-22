//
//  SightReadingView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 19/08/22.
//

import SwiftUI

struct SightReadingView: View {
    @StateObject var conductor = InstrumentEXSConductor()
    @State var keyInfo: KeyInfo?
    @State var onTap = false
    
    var body: some View {
        VStack{
            HStack {
                Button(action: { self.onTap.toggle() } ) {
                    Text("Start")
                        .font(.system(size: 22, weight: .bold))
                }
                Spacer()
                
                Text("Twinkle Twinkle")
                    .font(.system(size: 24, weight: .semibold))
                
                Spacer()
            }
            .padding()
            
            SRParanadaView()
            
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
}

struct SightReadingView_Previews: PreviewProvider {
    static var previews: some View {
        SightReadingView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
