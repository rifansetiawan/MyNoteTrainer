//
//  PopUpCorrectClefQuizView.swift
//  MyNoteTrainer
//
//  Created by Muhammad Rifan Setiawan on 23/08/22.
//

import SwiftUI

struct PopUpCorrectClefQuizView: View {
    
   var buttonColor : Color = Color("buttonNextPopUp")
    var body: some View {
        VStack{
            Image("ceklis")
            HStack {
                Text("Awesome")
                    .font(.system(size: 18, weight: .semibold))
            }.padding()
            
            HStack{
                Text("Congratulations you have done a great lesson. Keep it up!")
                    .foregroundColor(Color.black)
            }
            
            NavigationLink(destination: ClefQuizView(), label: {
                Text("Next").frame(width: 200, height: 50, alignment: .center).background(buttonColor).foregroundColor(Color.black).cornerRadius(30)
            })
            NavigationLink(destination: ClefQuizView(), label: {
                Text("Back to learn").frame(width: 200, height: 50, alignment: .center).background(.white).foregroundColor(Color.black).cornerRadius(30).overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(buttonColor, lineWidth: 4)
                )
            })
            
            

           
        }
    }
}

struct PopUpCorrectClefQuizView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpCorrectClefQuizView()
    }
}
