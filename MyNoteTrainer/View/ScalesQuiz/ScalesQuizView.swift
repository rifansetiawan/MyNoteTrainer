//
//  ScalesQuizView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 22/08/22.
//

import SwiftUI

struct ScalesQuizView: View {
    //number of question
    @State var i : Int = 0
    
    //var for the score
    @State var score = 0
    @State private var showActionSheet = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 40) {
                HStack {
                    Spacer()
                    ZStack{
                        RoundedRectangle(cornerRadius: 80)
                            .frame(width: 150, height: 25)
                            .border(Color.primaryColor)
                            .foregroundColor(.clear)
                        
                        HStack{
                            ForEach((1...4).reversed(), id: \.self) {_ in
                                Rectangle()
                                    .frame(width: 15, height: 15)
                                    .border(Color.primaryColor)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                
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
                
                    HStack(spacing: 0) {
                        ZStack{
                            VStack{
                                Image("sharp")
                                    .offset(x: 0, y: 6)
                            }
                            .offset(x: 0, y: -74.5)
    //                        .background(.green)
                        }
                        .frame(maxHeight: 85, alignment: .bottom)
                        ZStack{
                            VStack{
                                Image("sharp")
                                    .offset(x: 0, y: 6)
                            }
                            .offset(x: 0, y: -63)
    //                        .background(.green)
                        }
                        .frame(maxHeight: 85, alignment: .bottom)
                    }
                }
                }
                
                Text("... Major")
                    .font(.system(size: 36, weight: .semibold))
                
                
                HStack {
                    if(self.i < scaleQuiz.count){
                        //pilihan 1
                        Button(action:{
                            self.showActionSheet = true
                            self.buttonAction(n: 0)
                            
                        },label: {
                            Text(scaleQuiz[self.i].answer[0])
                                .font(.system(size: 45, weight: .semibold))
                                .foregroundColor(.primaryColor)
                                .padding()
                                .frame(maxWidth: 74, maxHeight: 74)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primaryColor,lineWidth: 2)
                                )
                    })
                        //pilihan 2
                        Button(action:{
                            self.showActionSheet = true
                            self.buttonAction(n: 1)
                            
                        },label: {
                            Text(scaleQuiz[self.i].answer[1])
                                .font(.system(size: 45, weight: .semibold))
                                .foregroundColor(.primaryColor)
                                .padding()
                                .frame(maxWidth: 74, maxHeight: 74)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primaryColor,lineWidth: 2)
                                )
                    })
                        //pilihan 3
                        Button(action:{
                            self.showActionSheet = true
                            self.buttonAction(n: 2)
                            
                        },label: {
                            Text(scaleQuiz[self.i].answer[2])
                                .font(.system(size: 45, weight: .semibold))
                                .foregroundColor(.primaryColor)
                                .padding()
                                .frame(maxWidth: 74, maxHeight: 74)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primaryColor,lineWidth: 2)
                                )
                    })
                        //pilihan 4
                        Button(action:{
                            self.showActionSheet = true
                            self.buttonAction(n: 3)
                            
                        },label: {
                            Text(scaleQuiz[self.i].answer[3])
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
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
    //action of the buttons
    //n = answer [0,1,2,3]
    func buttonAction( n : Int){
        //if answer is correct increment score
//            if(scaleQuiz[self.i].correct == n){
//
//                //gambar jadi hijau
//            }
        //GO TO NEXT QUESTION
        self.i = self.i + 1
        
    }
}

struct ScalesQuizView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesQuizView()
    }
}
