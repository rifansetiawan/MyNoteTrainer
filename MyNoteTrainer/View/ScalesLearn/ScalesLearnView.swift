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
    
    let scales: [Scale] = [.CMaj, .GMaj, .DMaj, .AMaj, .EMaj, .BMaj, .FSharpMaj, .CSharpMaj]
    @State var noteNumber: Int8 = -1
    @State var scaleIndex: Int = 0 {
        didSet {
            self.noteNumber = scales[scaleIndex].notes[0].sound.key
        }
    }
    
    
    var body: some View {
        ZStack {
            Color.bgColor
                .ignoresSafeArea()
            
            VStack{
                ScalesParanadaView(noteNumber: noteNumber, scale: scales[scaleIndex])
                Spacer()
                InstrumentEXSView(conductor: conductor, onNoteOn: { i in
                    self.noteNumber = i
                })
                    .frame(maxWidth: .infinity, maxHeight: 120)
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
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        scaleIndex -= 1
                    }, label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(scaleIndex == 0 ? .grayColor : .secondaryColor)
                    })
                    .disabled(scaleIndex == 0)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        scaleIndex += 1
                    }, label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(scaleIndex == scales.count-1 ? .grayColor : .secondaryColor)
                    }).disabled(scaleIndex == scales.count-1)
                }
            }
            .navigationTitle(scales[scaleIndex].name)
        }
        .onAppear{
            scaleIndex = 0
        }
    }
}

struct ScalesLearnView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesLearnView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
