//
//  ScalesLearnView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 21/08/22.
//

import SwiftUI

struct ScalesLearnView: View {
    @StateObject var conductor = InstrumentEXSConductor()
    @State var keyInfo: KeyInfo?
    @State var onTap = false
    var body: some View {
        VStack{
            ScalesParanadaView(conductor: conductor)
            Spacer()
            InstrumentEXSView(conductor: conductor)
                .frame(maxWidth: .infinity, maxHeight: 175)
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
        .navigationTitle("Play Scale G")
    }
}

struct ScalesLearnView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesLearnView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
