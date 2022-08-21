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
        NavigationView{
            VStack{
                ScalesParanadaView()
                Spacer()
                InstrumentEXSView(conductor: conductor)
                    .frame(maxWidth: .infinity, maxHeight: 175)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Play Scale G")
                }
            }
        }
        
    }
}

struct ScalesLearnView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesLearnView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
