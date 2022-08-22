//
//  ClefLearnScreen.swift
//  MyNoteTrainer
//
//  Created by Mikhael Budi Mulya Marpaung on 21/08/22.
//

import SwiftUI
import AVKit

struct ClefLearnScreen: View {
    @State var audioPlayer: AVAudioPlayer!
    var vm: ClefViewModel = ClefViewModel()
    private var whiteKeys : [Int8] = [60, 62, 64, 65, 67, 69, 71, 72]
    private var blackKeys : [Int8] = [61, 63, 66, 68, 70]
    var notes: [Note] = []
    @State private var tappedKey: Int8 = -1
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                ledgerLines(tappedKey: tappedKey)
                Spacer()
                
                Text("\(tappedKey)")
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 305)
                    
                    HStack(spacing: 5){
                        
                        ForEach(whiteKeys, id: \.self){key in
                            
                            Button {
                                self.vm.play(toneKey: key)
                                self.tappedKey = key
                            } label: {
                                Rectangle()
                                    .frame(width: 45, height: 300)
                                    .foregroundColor(.white)
                                    .cornerRadius(radius: 7, corners: [.bottomLeft, .bottomRight])
                            }
                        }
                    }
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
                            .padding(.trailing, key == 63 ? 95 : 0)
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
                    .padding(.trailing, 160)
                    .shadow(color: tappedKey == 60 || tappedKey == 62 ? .primaryColor : .clear, radius: 8,x: 0, y: tappedKey == 60 ? 0 : tappedKey == 62 ? -5 : 0)
            }
            HStack{
                Image("trebleClef")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 160, height: 172)
                    .padding(.top, 15)
                
                Spacer()
            }
            
            HStack(spacing: -30){
                Spacer()
                Image(tappedKey == 60 ? "quarterNoteBlue" : "quarterNote")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    
                    .padding(.top, 100)
                
                Image(tappedKey == 62 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 70, height: 70)
                
                .padding(.top, 70)
                
                Image(tappedKey == 64 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 70, height: 70)
                
                .padding(.top, 40)
                
                Image(tappedKey == 65 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 70, height: 70)
                
                .padding(.top, 10)
                
                Image(tappedKey == 67 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.bottom, 21)
                
                Image(tappedKey == 69 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.bottom, 48)
                
                Image(tappedKey == 71 ? "quarterNoteBlue" : "quarterNote")
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.bottom, 75)
                
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

