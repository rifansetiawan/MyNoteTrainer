//
//  GarisParanadaView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 21/08/22.
//

import SwiftUI

struct GarisParanadaView: View {
    var body: some View {
        ZStack(alignment: .trailing){
            VStack(spacing: 18){
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                    .foregroundColor(Color.grayColor)
                Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                .foregroundColor(Color.grayColor)
            }
            HStack {
                Image("kunciG")
                    .resizable()
                .frame(width: 127, height: 127)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

struct GarisParanadaView_Previews: PreviewProvider {
    static var previews: some View {
        GarisParanadaView()
    }
}
