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
    
    @State private var location: CGPoint = CGPoint(x: 188.66, y: 166)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil // 1
    @State var isShowPopup: Bool = false
    
    
    var body: some View {
        ZStack{
                VStack(spacing: 20){
                ForEach((1...5).reversed(), id: \.self) {_ in
                    Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 4).ignoresSafeArea()
                    .foregroundColor(Color.black)
                }
                
            }
            
            HStack(spacing: 1){
                Image("kunciG")
                Spacer()
            }

           
        }.padding(.top, 200)
        ZStack{
            Print(location.y)
            Rectangle().fill(Color.white, stroke: StrokeStyle(lineWidth:w, dash:d)).frame(width: 110, height: 110)
            Image("blue_musical_note")
                .position(location)
                .gesture(
                    simpleDrag
                )

        }

        
        
    }
    func checkLocation(){
        if location.y < -41 {
            isShowPopup = true
        }
        if isShowPopup {
            PopupQuizView()
                .myCustomPopUp(onTapoutside: {
                    isShowPopup = false
                }, withCloseBtn: true)
        }
    }
    
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
        ClefQuizView()
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
