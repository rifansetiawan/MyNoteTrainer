//
//  ProgressBarView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 04/09/22.
//

import SwiftUI

struct ProgressBar: View {
    var width: CGFloat = 350
    var height: CGFloat = 18
    var percent: CGFloat = 100
    var color1 = Color.primaryColor
    var color2 = Color.purple
    
    var body: some View {
        let multiplier = width / 100
        
        ZStack(alignment: .leading){
            Rectangle()
                .frame(width: width, height: height)
                .foregroundColor(.white)
            
            Rectangle()
                .frame(width: percent * multiplier, height: height)
                .background(
                    LinearGradient(gradient: Gradient(colors: [color1,color2]), startPoint: .leading, endPoint: .trailing)
                )
                .foregroundColor(.clear)
        }
        
        
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}
