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
    
//    var generatedBlock : [[Int]]
//    var totalTime: TimeInterval
//    var onStart: () -> ()
//    @Binding var x: CGFloat
//    @State var totalX: CGFloat
//    @ObservedObject var coachmarkManager: CoachmarkManager
//
//    var onTap: (_ tapTime: TimeInterval) -> ()
//    @Binding var tapIndicatorState : TapIndicatorState
//
//    var blockWidth = CGFloat(Config.BLOCK_WIDTH)
//
//    @State var isPressed : Bool = false
//    @State var buttonLabel : TapButtonState = .start
//
//    @State var indicatorFrame : CGRect?
//    @State var indicatorSize : CGSize?
//
//
//    var coachmarkStepIndex : Int = 0
    
    var body: some View {
        NavigationView{
            ZStack{
//                let isShowIndicatorCm = coachmarkManager.coachmarkIndex == 0
//                let isShowMetronomeCm = coachmarkManager.coachmarkIndex == 1
//                let isShowIndicatorColorGreenCm = coachmarkManager.coachmarkIndex == 3
//                let isShowIndicatorColorRedCm = coachmarkManager.coachmarkIndex == 2
//                let shadowColor : Color = isShowIndicatorCm || isShowIndicatorColorGreenCm || isShowIndicatorColorRedCm ? .white : .clear
//                let foregroundColor: Color = isShowIndicatorCm ? .blue : isShowIndicatorColorGreenCm ? .green : isShowIndicatorColorRedCm ? .red : tapIndicatorState == .right ? .green : tapIndicatorState == .wrong ? .red : .blue
//                Rectangle()
//                    .frame(width: blockWidth, height: 50, alignment: .center)
//                    .foregroundColor(foregroundColor)
//                    .offset(x: 0, y: 0)
//                    .opacity(0.3)
//                    .shadow(color: shadowColor, radius: 10)
//                    .shadow(color: shadowColor, radius: 10)
//                    .shadow(color: shadowColor, radius: 10)
//                    .background(reader(isShowCoachmark: isShowIndicatorCm || isShowIndicatorColorGreenCm || isShowIndicatorColorRedCm, type: .tap, coachmarkManager: coachmarkManager))
//                    .zIndex(isShowIndicatorCm || isShowIndicatorColorGreenCm || isShowIndicatorColorRedCm ? 1 : 0)
//                Rectangle()
//                    .frame(width: 1, height: 50, alignment: .center)
//                    .foregroundColor(.black)
//                    .offset(x: 0, y: 0)
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
            .ignoresSafeArea()
        }
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

