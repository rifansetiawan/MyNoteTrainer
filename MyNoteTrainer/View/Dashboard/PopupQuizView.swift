//
//  PopupView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 19/08/22.
//

import SwiftUI

struct PopupQuizView: View {
    var body: some View {
        VStack{
            Image("PopupBack")
            HStack {
                Text("Choose Quiz")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }.padding()
            
            NavigationLink(destination: MusicalQuizView(), label: {
                HStack{
                    Image("Popup1")
                        .frame(width: 97, height: 59)
                    VStack(alignment: .leading){
                        Text("Musical Note")
                            .foregroundColor(Color.black)
                        
                        HStack{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color.green)
                            Text("Beginner")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.gray)
                        }
                    }
                    Spacer()
                }
                .padding()
            })
            NavigationLink(destination: ClefQuizView(), label: {
                HStack{
                    Image("Popup2")
                    
                    VStack(alignment: .leading){
                        Text("Clef")
                            .foregroundColor(Color.black)
                        
                        HStack{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color.green)
                            Text("Beginner")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.gray)
                        }
                    }
                    Spacer()
                }
                .padding()
            })
            
            
            Button(action: {}, label: {
                HStack{
                    Image("Popup3")
                        .frame(width: 97, height: 59)
                    VStack(alignment: .leading){
                        Text("Music Scale")
                            .foregroundColor(Color.black)
                        
                        HStack{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color.brownColor)
                            Text("Intermediate")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.gray)
                        }
                    }
                    Spacer()
                }
                .padding()
            })
            
        }.padding(.bottom, 100)
    }
}

struct PopupQuizView_Previews: PreviewProvider {
    static var previews: some View {
        PopupQuizView()
    }
}
