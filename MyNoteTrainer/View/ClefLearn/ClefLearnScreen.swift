//
//  ClefLearnScreen.swift
//  MyNoteTrainer
//
//  Created by Mikhael Budi Mulya Marpaung on 21/08/22.
//

import SwiftUI

struct ClefLearnScreen: View {
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                ledgerLines()
                Spacer()
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 255)
                    
                    HStack(spacing: 5){
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 250)
                                .foregroundColor(.white)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 250)
                                .foregroundColor(.white)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 250)
                                .foregroundColor(.white)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 250)
                                .foregroundColor(.white)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 250)
                                .foregroundColor(.white)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 250)
                                .foregroundColor(.white)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 250)
                                .foregroundColor(.white)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                    }
                    HStack(spacing: 5){
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 150)
                                .foregroundColor(.black)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 150)
                                .foregroundColor(.black)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        .padding(.trailing, 55)
                        
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 150)
                                .foregroundColor(.black)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 150)
                                .foregroundColor(.black)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 50, height: 150)
                                .foregroundColor(.black)
                                .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle("Treble Clef")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 27, height: 27)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct ClefLearnScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClefLearnScreen()
    }
}

struct ledgerLines: View {
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 25){
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(.gray)
            }
            HStack{
                Image("trebleClef")
                    .resizable()
                    .frame(width: 172, height: 172)
                    .padding(.top, 15)
                
                Spacer()
            }
        }
    }
}

struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

