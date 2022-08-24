//
//  ScalesQuizView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 22/08/22.
//

import SwiftUI

struct ScalesQuizView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //number of question
    @State var i : Int = 0
    
    //var for the score
    @State var score = 0
    @State private var showActionSheet = false
    var quizes: [ScaleQuizModel] = ScaleQuizModel.scaleQuizes.shuffled()
    var buttons: [ScaleQuizButtonModel] = ScaleQuizButtonModel.scaleQuizButtons.shuffled()
    @State var quizIndex: Int = 0
    @State var answer: String = ""
    @State var isWrong: Bool = false
    @State var isShowPopup: Bool = false
    var body: some View {
        ZStack(alignment: .top){
            VStack(spacing: 40) {
                HStack {
                    Spacer()
                    if(isWrong) {
                        Image("ceklisFalse")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                    }
                    
                    //                    ZStack{
                    //                        RoundedRectangle(cornerRadius: 80)
                    //                            .frame(width: 150, height: 25)
                    //                            .border(Color.primaryColor)
                    //                            .foregroundColor(.clear)
                    //
                    //                        HStack{
                    //                            ForEach((1...4).reversed(), id: \.self) {_ in
                    //                                Rectangle()
                    //                                    .frame(width: 15, height: 15)
                    //                                    .border(Color.primaryColor)
                    //                                    .foregroundColor(.green)
                    //                            }
                    //                        }
                    //                    }
                }.frame(height: 85, alignment: .trailing)
                
                ScaleQuizContent(scaleQuiz: quizes[quizIndex], answer: answer)
                
                VStack{
                    HStack {
                        ForEach(0..<4, id:\.self) { i in
                            ScaleQuizButtonView(button: buttons[i], onTap: onTapButton)
                        }
                    }
                    HStack {
                        ForEach(4..<6, id:\.self) { i in
                            ScaleQuizButtonView(button: buttons[i], onTap: onTapButton)
                        }
                    }
                }
                
                Spacer()
                
            }
//            .background(.blue)
            
            if(isShowPopup) {
                PopUpCorrectQuizView(onPressPrimary: quizIndex < quizes.count-1 ? ({
                    if(quizes.count-1 > quizIndex) {
                        self.quizIndex += 1
                    }
                    isShowPopup = false
                }) : nil, onPressSecondary: {
                    presentationMode.wrappedValue.dismiss()
                })
                .myCustomPopUp()
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: quizIndex, perform: { i in
            answer = ""
        })
    
    }
    //action of the buttons
    //n = answer [0,1,2,3]
    func onTapButton(button: ScaleQuizButtonModel){
        let buttonScaleName = button.scale.name
        let buttonName = button.name
        let quizScaleName = quizes[quizIndex].scale.name
        if( buttonScaleName == quizScaleName ) {
//            self.scaleIndex += 1
            answer = buttonName
            self.isShowPopup = true
        } else {
            self.isWrong = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isWrong = false
            })
        }
        
        
    }
}

struct ScaleQuizContent: View {
    var scaleQuiz: ScaleQuizModel
    var answer: String
    
    var offsetParanada: Double = 20.5
    
    var body: some View {
        VStack{
            ZStack{
                VStack(spacing: 18){
                    ForEach((1...5).reversed(), id: \.self) {_ in
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                            .foregroundColor(Color.grayColor)
                    }
                    
                }
                
                HStack {
                    Image("kunciG")
                    
                    HStack(spacing: -5) {
                        let scale = scaleQuiz.scale
                        ForEach(scale.accTones, id:\.self) { acd in
                            ZStack{
                                VStack{
                                    Image("\(scale.scaleAcc.image)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 30)
                                        .offset(x: 0, y: scale.scaleAcc
                                                == .sharp ? 10 : 0)
                                }
    //                                                        .background(acd.rawValue == conductor.noteNumber )
                                .offset(x: 0, y: acd.accidentalPosition * offsetParanada)
                                
                            }
                            .frame(maxHeight: 71, alignment: .bottom)
                        }
                    }
                }
            }
            HStack(alignment: .bottom) {
                ZStack {
                    Text(answer)
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundColor(.primaryColor)
                        .offset(x: 0, y: -10)
                    Text(".....")
                        .font(.system(size: 36))
                }
                .offset(x: 0, y: 5)
                Text("Major")
                    .font(.system(size: 36, weight: .semibold))
            }
        }
        
        
        
    }
}

struct ScaleQuizButtonView: View {
    var button: ScaleQuizButtonModel
    var onTap: (_ button: ScaleQuizButtonModel) -> ()
    var body: some View {
        Button(action:{
            onTap(button)
            
        },label: {
            Text(button.name)
                .font(.system(size: 45, weight: .semibold))
                .foregroundColor(.primaryColor)
                .padding()
                .frame(maxWidth: 74, maxHeight: 74)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primaryColor,lineWidth: 2)
                )
        })
    }
}

struct ScalesQuizView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesQuizView()
    }
}
