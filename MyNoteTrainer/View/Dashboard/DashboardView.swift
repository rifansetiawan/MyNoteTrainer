//
//  SwiftUIView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 18/08/22.
//

import SwiftUI

struct DashboardView: View {
    @State var isShowPopup: Bool = false
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.bgColor
                .ignoresSafeArea()
                
                VStack(spacing: 15){
                    
                        
                        Button(action: {}, label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 345, height: 105)
                                    .foregroundColor(Color.white)
                                HStack{
                                    Image("MusicalNote")
                                    VStack{
                                        Text("Musical Notes")
                                            .font(.system(size: 16, weight: .semibold))
                                            .frame(width: 145, height: 16, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        HStack{
                                            Circle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(Color.green)
                                            Text("Beginner")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color.gray)
                                            
                                        }.frame(width: 145, height: 16, alignment: .leading)
                                        
                                        HStack{
                                            Image(systemName: "book")
                                                .foregroundColor(Color.gray)
                                            Text("4 Lessons")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color.gray)
                                        }.frame(width: 145, height: 16, alignment: .leading)
                                    }
                                }
                                .frame(width: 345, height: 105, alignment: .leading)
                                
                            }
                        })
                        
                        Button(action: {}, label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 345, height: 105)
                                    .foregroundColor(Color.white)
                                HStack{
                                    Image("Clef")
                                    VStack{
                                        Text("Clef")
                                            .font(.system(size: 16, weight: .semibold))
                                            .frame(width: 145, height: 16, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        HStack{
                                            Circle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(Color.green)
                                            Text("Beginner")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color.gray)
                                        }.frame(width: 145, height: 16, alignment: .leading)
                                        
                                        HStack{
                                            Image(systemName: "book")
                                                .foregroundColor(Color.gray)
                                            Text("4 Lessons")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color.gray)
                                        }.frame(width: 145, height: 16, alignment: .leading)
                                        
                                    }
                                }
                                .frame(width: 345, height: 105, alignment: .leading)
                                
                            }
                        })
                    NavigationLink(destination: ScalesLearnView()) {
                        Button(action: {
                            
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 345, height: 105)
                                    .foregroundColor(Color.white)
                                HStack{
                                    Image("MusicScale")
                                    VStack{
                                        Text("Scales")
                                            .font(.system(size: 16, weight: .semibold))
                                            .frame(width: 145, height: 16, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        HStack{
                                            Circle()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(Color.brownColor)
                                            Text("Intermediate")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color.gray)
                                        }.frame(width: 145, height: 16, alignment: .leading)
                                        
                                        HStack{
                                            Image(systemName: "book")
                                                .foregroundColor(Color.gray)
                                            Text("4 Lessons")
                                                .font(.system(size: 12, weight: .regular))
                                                .foregroundColor(Color.gray)
                                        }.frame(width: 145, height: 16, alignment: .leading)
                                        
                                    }
                                }
                                .frame(width: 345, height: 105, alignment: .leading)
                                
                            }
                        })
                    }
                        
                        
                    Button(action: {
                        isShowPopup = true
                    }, label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 345, height: 105)
                                    .foregroundColor(Color.white)
                                
                                Image("Quiz")
                                
                                Text("Quiz")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(Color.white)
                                    .shadow(color: .black, radius: 3)
                            }
                        })
                    }
                if isShowPopup {
                    PopupQuizView()
                        .myCustomPopUp(onTapoutside: {
                            isShowPopup = false
                        }, withCloseBtn: true)
                }
                
            }
        }
            
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
