//
//  ClefQuizView.swift
//  MyNoteTrainer
//
//  Created by Muhammad Rifan Setiawan on 23/08/22.
//

import SwiftUI

struct ClefQuizView: View {
    // stroke line width, dash
    let w: CGFloat   = 2
    let d: [CGFloat] = [5,2]

    @State var position = CGSize.zero
    
    @State private var location: CGPoint = CGPoint(x: 188.66, y: 115)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil // 1
    @State var isShowPopup: Bool = false
    @State var isShowSuccessPopUp: Bool = false
    @State var isFalse: Bool = false
    var quizes : [MusicalNoteQuizModel] = MusicalNoteQuizModel.quizes
    @State var isShowTutorial: Bool = true
    @State var quizIndex: Int = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var index: Int 
    
    
    var body: some View {

        VStack{
            VStack(spacing:20){
                Text("Drag the note to the right position")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color.primaryColor)
                
                Text("E Note")
                    .font(.system(size: 36, weight: .semibold))
                
            }.padding(.top, 50)
            
            
            ZStack{
                    VStack(spacing: 20){
                    ForEach((1...5).reversed(), id: \.self) {_ in
                        Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 4).ignoresSafeArea()
                        .foregroundColor(Color.black)
                    }
                    
                }
                HStack{
                    Image(isFalse ? "false" : "")
                    
                }.frame(width: 300, height: 100, alignment: .trailing)
                    
                
                HStack(spacing: 1){
                    Image("kunciG")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                    Spacer()
                }

               
            }.padding(.top, 100)
            ZStack{
                Print(location.y)
                Rectangle().fill(Color.white, stroke: StrokeStyle(lineWidth:w, dash:d)).frame(width: 110, height: 110)
                Image("blue_musical_note")
                    .position(location)
                    .gesture(
                        simpleDrag
                    )
            }
            
            Button(action:
                    {
                if location.y <= -52 && location.y >= -60 {
                    isShowSuccessPopUp = true
                }
                else {
                    isFalse = true
                }
                
                
            }, label: {
                Text("Check").frame(width: 300, height: 50, alignment: .center).background(Color.primaryColor)
                    .foregroundColor(Color.black).cornerRadius(30)
                    .font(.body.bold())
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.primaryColor, lineWidth: 4)
                    )
            })
            if(isShowSuccessPopUp) {
                PopUpCorrectQuizView(onPressPrimary: {
                    index = 1
                }, onPressSecondary: {
                    presentationMode.wrappedValue.dismiss()
                })
                .myCustomPopUp()
            }
            
    //        if isShowPopup {
    //            PopUpCorrectQuizView()
    //                .myCustomPopUp(onTapoutside: {
    //                    isShowPopup = false
    //                }, withCloseBtn: true)
    //        }
            
            
        }
        .navigationTitle("Treble Clef")
        .navigationBarTitleDisplayMode(.inline)

        
    }
    func checkLocation(){
        if location.y < -41 {
            isShowPopup = true
        }
        if(isShowSuccessPopUp) {
            PopUpCorrectQuizView(onPressPrimary: { index = 1 }, onPressSecondary: {
                presentationMode.wrappedValue.dismiss()
            })
            .myCustomPopUp()
        }
    }
    
//    func falseLocation(){
//
//    }
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location // 3
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }
}

struct ClefQuizView_Previews: PreviewProvider {
    static var previews: some View {
        ClefQuizView(index: .constant(1))
    }
}
extension Shape {
    /// fills and strokes a shape
    public func fill<S:ShapeStyle>(
        _ fillContent: S,
        stroke       : StrokeStyle
    ) -> some View {
        ZStack {
            self.fill(fillContent)
            self.stroke(style:stroke)
        }
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
