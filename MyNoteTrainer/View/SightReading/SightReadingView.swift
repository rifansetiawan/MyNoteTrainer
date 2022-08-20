//
//  SightReadingView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 19/08/22.
//

import SwiftUI

struct SightReadingView: View {
//    @State var keyInfo: KeyInfo?
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
            
            ZStack(alignment: .top){
                VStack(spacing: 18){
                    Rectangle()
                        .frame(width: 1000, height: 3, alignment: .center)
//                        .offset(x: 0, y: -72)
                    Rectangle()
                        .frame(width: 1000, height: 3, alignment: .center)
//                        .offset(x: 0, y: -64)
                    Rectangle()
                        .frame(width: 1000, height: 3, alignment: .center)
//                        .offset(x: 0, y: -56)
                    Rectangle()
                        .frame(width: 1000, height: 3, alignment: .center)
//                        .offset(x: 0, y: -48)
                    Rectangle()
                        .frame(width: 1000, height: 3, alignment: .center)
//                        .offset(x: 0, y: -40)
                }
                
                Image("twinkle")
                    .frame(alignment: .center)
                    .offset(x: self.onTap ? -1250 : 300, y: -18)
                    .animation(
                        .linear(duration: 15.0)
                    )
            }
            
            Spacer()
//            Text("key info \(keyInfo?.n ?? -1)")
            PianoView()
        }.padding(40)
        
    }
}

struct SightReadingView_Previews: PreviewProvider {
    static var previews: some View {
        SightReadingView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
