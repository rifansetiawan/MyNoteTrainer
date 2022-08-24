//
//  PopUpCorrectClefQuizView.swift
//  MyNoteTrainer
//
//  Created by Muhammad Rifan Setiawan on 23/08/22.
//

import SwiftUI

struct PopUpCorrectQuizView: View {
    
    var buttonColor : Color = Color("buttonNextPopUp")
    var onPressPrimary: (() -> ())? = nil
    var onPressSecondary: (() -> ())? = nil
    var body: some View {
        VStack(alignment: .center, spacing: 25){
            ZStack {
                Image("backpop")
                Image("ceklis")
            }
            HStack {
                Text("Awesome")
                    .font(.system(size: 18, weight: .semibold))
            }
            
            HStack(alignment: .center){
                
                Text("Congratulations you have done a great lesson. Keep it up!")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(15)
            }
            
            if(onPressPrimary != nil) {
                Button(action: {
                    onPressPrimary!()
                }, label: {
                    Text("Next").frame(width: 300, height: 50, alignment: .center).background(Color.primaryColor).foregroundColor(.blackColor).cornerRadius(30)
                        .font(.body.bold())
                })
            }
            
            if(onPressSecondary != nil) {
                Button(action: {
                    onPressSecondary!()
                }, label: {
                    Text("Back to learn").frame(width: 300, height: 50, alignment: .center).background(.white).foregroundColor(Color.black).cornerRadius(30).font(.body.bold())
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.primaryColor, lineWidth: 4)
                        )
                })
            }
        }
        .padding(.horizontal, 25)
        .padding(.top, 45)
        .padding(.bottom, 65)
    }
}

struct PopUpCorrectClefQuizView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpCorrectQuizView()
    }
}
