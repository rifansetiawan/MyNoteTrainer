//
//  ClefLearnScreen.swift
//  MyNoteTrainer
//
//  Created by Mikhael Budi Mulya Marpaung on 21/08/22.
//

import SwiftUI
import AVKit
import Foundation

enum TapIndicatorState {
    case right
    case wrong
    case neutral
}

enum TapButtonState: String {
    case start = "Start"
    case tap = "Tap"
    case ready = "Ready"
    case restart = "Restart"
}


struct ClefLearnScreen: View {
    @State var audioPlayer: AVAudioPlayer!
    var vm: ClefViewModel = ClefViewModel()
    private var whiteKeys : [Int8] = [60, 62, 64, 65, 67, 69, 71, 72]
    private var blackKeys : [Int8] = [61, 63, 66, 68, 70]
    var notes: [Note] = []
    @State private var tappedKey: Int8 = -1
    @State private var isShowTutorial: Bool = false

    
    var body: some View {
//        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    ledgerLines(tappedKey: tappedKey)
                    Spacer()
                    
                    ZStack{
                        Rectangle()
                            .frame(width: .infinity, height: 360)
                            .foregroundColor(.black)
                        
                        HStack(spacing: 5){
                            
                            ForEach(whiteKeys, id: \.self){key in
                                
                                Button {
                                    self.vm.play(toneKey: key)
                                    self.tappedKey = key
                                } label: {
                                    Rectangle()
                                        .frame(width: 45, height: 305)
                                        .foregroundColor(.white)
                                        .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                                }
                            }
                        }
                        .padding(.bottom, 50)
                        HStack(spacing: 7){
                            
                            ForEach(blackKeys, id: \.self){key in
                                
                                Button {
                                    self.vm.play(toneKey: key)
                                } label: {
                                    Rectangle()
                                        .frame(width: 45, height: 200)
                                        .foregroundColor(.black)
                                        .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                                }
                                .padding(.trailing, key == 63 ? 45 : 0)
                                .padding(.leading, key == 61 ? 25 : 0)
                            }
                            Spacer()
                        }
                        .padding(.bottom, 160)
                    }
                }
                .navigationTitle("Treble Clef")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.isShowTutorial = true
                        }, label: {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 27, height: 27)
                                .foregroundColor(.black)
                        })

                    }
                    
                }
                
                if( isShowTutorial) {
                    clefTutorial(onTap: {
                        self.isShowTutorial = false
                    })
                }
            }
            .ignoresSafeArea()
//        }
    }
}

struct ClefLearnScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClefLearnScreen()
    }
}

struct ledgerLines: View {
    var tappedKey: Int8
    
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
                    .foregroundColor(tappedKey == 71 ? .primaryColor : .gray)
                    .shadow(color: tappedKey == 69 ? .primaryColor : .clear, radius: 8,x: 0, y: tappedKey == 69 ? 5 : tappedKey == 71 ? 0 : 0)
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(tappedKey == 67 ? .primaryColor : .gray)
                    .shadow(color: tappedKey == 65 || tappedKey == 69  ? .primaryColor : .clear, radius: 8,x: 0, y: tappedKey == 65 ? 5 : tappedKey == 67 ? 0 : tappedKey == 69 ? -5 : 0)
                Rectangle()
                    .frame(width: .infinity, height: 4)
                    .foregroundColor(tappedKey == 64 ? .primaryColor : .gray)
                    .shadow(color: tappedKey == 62 || tappedKey == 65 ? .primaryColor : .clear, radius: 8,x: 0, y: tappedKey == 62 ? 5 : tappedKey == 64 ? 0 : tappedKey == 65 ? -5 : 0)
                Rectangle()
                    .frame(width: 45, height: 4)
                    .foregroundColor(tappedKey == 60 ? .primaryColor : .gray)
                    .padding(.trailing, 166)
                    .shadow(color: tappedKey == 60 || tappedKey == 62 ? .primaryColor : .clear, radius: 8,x: 0, y: tappedKey == 60 ? 0 : tappedKey == 62 ? -5 : 0)
                
            }
            HStack{
                Image("trebleClef")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 127, height: 172)
                    .padding(.top, 15)
                
                Spacer()
            }
            
            HStack(spacing: -30){
                Spacer()
                Image(tappedKey == 60 ? "quarterNoteBlue" : "quarterNote")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 65, height: 65)
                    .padding(.top, 100)
                
                Image(tappedKey == 62 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 65, height: 65)
                .padding(.top, 73)
                
                Image(tappedKey == 64 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 65, height: 65)
                .padding(.top, 43)
                
                Image(tappedKey == 65 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 65, height: 65)
                .padding(.top, 13)
                
                Image(tappedKey == 67 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 65, height: 65)
                .padding(.bottom, 18)
                
                Image(tappedKey == 69 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 65, height: 65)
                .padding(.bottom, 45)
                
                Image(tappedKey == 71 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 65, height: 65)
                .padding(.bottom, 72)
                
                Image(tappedKey == 72 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 65, height: 65)
                .padding(.bottom, 102)
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


struct clefTutorial: View {
    
    var vm: ClefViewModel = ClefViewModel()
     var whiteKeys : [Int8] = [60, 62, 64, 65, 67, 69, 71, 72]
     var blackKeys : [Int8] = [61, 63, 66, 68, 70]
    var notes: [Note] = []
    @State  var tappedKey: Int8 = -1
    @State var onTap : ()->()
    @State var step: Int = 1
    var body: some View{
        ZStack {
            if( step == 1) {
                ZStack{
                    VStack{
                        HStack{
                            Spacer()
                            Text("Treble Clef")
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.title3)
                                .padding(.trailing, 100)
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 27, height: 27)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        
                        ZStack{
                            Rectangle()
                                .frame(width: .infinity, height: 360)
                                .foregroundColor(.black)
                            
                            HStack(spacing: 5){
                                
                                ForEach(whiteKeys, id: \.self){key in
                                    
                                    Button {
                                        self.vm.play(toneKey: key)
                                        self.tappedKey = key
                                    } label: {
                                        Rectangle()
                                            .frame(width: 45, height: 305)
                                            .foregroundColor(.white)
                                            .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                                    }
                                }
                            }
                            .padding(.bottom, 50)
                            HStack(spacing: 7){
                                
                                ForEach(blackKeys, id: \.self){key in
                                    
                                    Button {
                                        self.vm.play(toneKey: key)
                                    } label: {
                                        Rectangle()
                                            .frame(width: 45, height: 200)
                                            .foregroundColor(.black)
                                            .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                                    }
                                    .padding(.trailing, key == 63 ? 45 : 0)
                                    .padding(.leading, key == 61 ? 25 : 0)
                                }
                                Spacer()
                            }
                            .padding(.bottom, 160)
                            
                            
                        }
                    }
                    .ignoresSafeArea()
                    
                    Rectangle()
                        .frame(width: .infinity, height: .infinity)
                        .ignoresSafeArea()
                        .opacity(0.7)
                    
                    VStack{
                        Image("clefPage1")
                            .resizable()
                            .frame(width: 365, height: 126, alignment: .center)
                        ZStack{
                            Image("clefPage1.1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 321, height: 149, alignment: .center)
                            
                            Text("""
        Staff is foundation upon which notes are drawn

        Modern staff comprises
        five(5) lines and four(4) spaces
        """)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                            .frame(width: 300, height: 100, alignment: .center)
                        }
                        .padding(.bottom, 200)
                        
                        
                        
                        Text("Tap anywhere to next")
                            .foregroundColor(.white)
                        
                    }
                }
                .onTapGesture{
                    self.step = 2
                }
            }
            else if (step == 2) {
                ZStack{
                    Text("tutorial 2")
                }
                    .onTapGesture{
                        self.step = 3
                    }
            } else if (step == 3) {
                Text("tutorial 3")
                    .onTapGesture{
                        self.step = 4
                    }
            } else if (step == 4) {
                Text("tutorial 4")
                    .onTapGesture{
                        self.step = 5
                    }
            } else if (step == 5) {
                Text("tutorial 5")
                    .onTapGesture{
                        self.onTap()
                    }
            }
            
        } .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}
    
struct clefTutorial_Previews: PreviewProvider {
    static var previews: some View {
        clefTutorial(onTap: {})
    }
}

struct clefTutorial2: View {
    
    var vm: ClefViewModel = ClefViewModel()
    private var whiteKeys : [Int8] = [60, 62, 64, 65, 67, 69, 71, 72]
    private var blackKeys : [Int8] = [61, 63, 66, 68, 70]
    var notes: [Note] = []
    @State private var tappedKey: Int8 = -1
    
    var body: some View{
        ZStack{
            VStack{
                //                    Spacer()
                //                    ZStack{
                //                        VStack(alignment: .center, spacing: 25){
                //                            Rectangle()
                //                                .frame(width: .infinity, height: 4)
                //                                .foregroundColor(.gray)
                //                            Rectangle()
                //                                .frame(width: .infinity, height: 4)
                //                                .foregroundColor(.gray)
                //                            Rectangle()
                //                                .frame(width: .infinity, height: 4)
                //                                .foregroundColor(.gray)
                //                            Rectangle()
                //                                .frame(width: .infinity, height: 4)
                //                                .foregroundColor(.gray)
                //                            Rectangle()
                //                                .frame(width: .infinity, height: 4)
                //                                .foregroundColor(.gray)
                //                        }
                //                        HStack{
                //                            Image("trebleClef")
                //                                .resizable()
                //                                .aspectRatio(contentMode: .fit)
                //                                .frame(width: 127, height: 172)
                //                                .padding(.top, 15)
                //
                //                            Spacer()
                //                        }
                //                        HStack(spacing: -30){
                //                            Spacer()
                //                            Image("quarterNote")
                //                                .resizable()
                //                                .aspectRatio(contentMode: .fit)
                //                                .frame(width: 65, height: 65)
                //                                .padding(.top, 100)
                //
                //                            Image("quarterNote")
                //                                .resizable()
                //                                .frame(width: 65, height: 65)
                //                                .padding(.top, 73)
                //
                //                            Image("quarterNote")
                //                                .resizable()
                //                                .frame(width: 65, height: 65)
                //                                .padding(.top, 43)
                //
                //                            Image("quarterNote")
                //                                .resizable()
                //                                .frame(width: 65, height: 65)
                //                                .padding(.top, 13)
                //
                //                            Image("quarterNote")
                //                                .resizable()
                //                                .frame(width: 65, height: 65)
                //                                .padding(.bottom, 18)
                //
                //                            Image("quarterNote")
                //                                .resizable()
                //                                .frame(width: 65, height: 65)
                //                                .padding(.bottom, 45)
                //
                //                            Image("quarterNote")
                //                                .resizable()
                //                                .frame(width: 65, height: 65)
                //                                .padding(.bottom, 72)
                //
                //                            Image("quarterNote")
                //                                .resizable()
                //                                .frame(width: 65, height: 65)
                //                                .padding(.bottom, 102)
                //
                //                        }
                //
                //                    }
                
                Spacer()
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 360)
                        .foregroundColor(.black)
                    
                    HStack(spacing: 5){
                        
                        ForEach(whiteKeys, id: \.self){key in
                            
                            Button {
                                self.vm.play(toneKey: key)
                                self.tappedKey = key
                            } label: {
                                Rectangle()
                                    .frame(width: 45, height: 305)
                                    .foregroundColor(.white)
                                    .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                            }
                        }
                    }
                    .padding(.bottom, 50)
                    HStack(spacing: 7){
                        
                        ForEach(blackKeys, id: \.self){key in
                            
                            Button {
                                self.vm.play(toneKey: key)
                            } label: {
                                Rectangle()
                                    .frame(width: 45, height: 200)
                                    .foregroundColor(.black)
                                    .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                            }
                            .padding(.trailing, key == 63 ? 45 : 0)
                            .padding(.leading, key == 61 ? 25 : 0)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 160)
                    
                    
                }
            }
            .ignoresSafeArea()
            
            Rectangle()
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
                .opacity(0.7)
            
            VStack{
                Image("clefPage1")
                    .resizable()
                    .frame(width: 365, height: 126, alignment: .center)
                
                Image("clefPage1.1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 321, height: 149, alignment: .center)
                    .padding(.bottom, 200)
                
                Text("Tap anywhere to next")
                    .foregroundColor(.white)
                
            }
            .onTapGesture {
                
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)

        .toolbar {
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
    
struct clefTutorial2_Previews: PreviewProvider {
    static var previews: some View {
        clefTutorial2()
    }
}
