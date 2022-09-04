//
//  PopupView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 19/08/22.
//

import SwiftUI

struct PopupViewModifier: ViewModifier {
    var onTapoutside: (() -> Void)?
    var withCloseBtn: Bool
    @State var popUpHeight : CGFloat = 0
    @State var isShow: Bool = true
    @State var y: CGFloat = 0
    
    
    func body(content: Content) -> some View {
        ZStack{
            VStack{
                Color.gray
                    .opacity(0.3)
                    .onTapGesture {
                        
                        if(onTapoutside != nil) {
                            onTap()
                            withAnimation(.linear(duration: 0.2) ){
                                y = popUpHeight
                            }
                        }
                        
                    }
            }

            
            VStack{
                Spacer()
//                VStack{
                    ZStack(alignment: .top){
                        content
                            
                        if(withCloseBtn) {
                            VStack {
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        onTap()
                                        withAnimation(.linear(duration: 0.2) ){
                                            y = popUpHeight
                                        }
                                    }, label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(.gray)
                                    })
                                    
                                }
                                .padding(20)
                                Spacer()
                                
                            }
                            
                        }
                        
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.white
                                .onAppear { /// 2.
                                    popUpHeight = proxy.size.height
                                    y = proxy.size.height
                                }
                        }
                    )
                    .cornerRadius(22, corners: [.topLeft, .topRight])
                    .frame(width: UIScreen.main.bounds.width, height: 0, alignment: .bottom)
                    .offset(y: y)
                        
                        
//                }.frame(minWidth: UIScreen.main.bounds.width, alignment: .bottom)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height)
            
            
        }.ignoresSafeArea().zIndex(1)
            .onAppear{
                withAnimation(.linear(duration: 0.2).delay(0.15)){
                    y = 0
                }
            }
            
    }
    
    func onTap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            onTapoutside!()
        }
    }
}

