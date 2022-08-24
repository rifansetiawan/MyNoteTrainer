//
//  ContentView.swift
//  Lock
//
//  Created by Balaji on 21/08/20.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        
        NavigationView{
            ZStack{
                Home()
            }
            .navigationTitle("Music Note")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

struct Home : View {
    
    @State var berhasil = false
    
    var body: some View{
        
        ZStack{
            
            // Lockscreen...
            
            if berhasil{
                
                //pop up awsome
            }
            else{
                
                NoteQuiz(jawaban: $berhasil)
            }
        }
    }
}

struct NoteQuiz: View {
    
    @State var noteList = ""
    @AppStorage("jawaban") var key = "1223"
    @Binding var jawaban : Bool
    @State var jawabanSalah = false
    let height = UIScreen.main.bounds.width
    
    var body: some View{
        
        VStack(spacing: 10){
    
            ZStack {
                VStack(spacing: 15){
                    ForEach((1...5).reversed(), id: \.self) {_ in
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 3).ignoresSafeArea()
                            .foregroundColor(Color.grayColor)
                    }
                }
                
                HStack(spacing: 10){
                    
                    // Password Circle View...
                    
                    ForEach(0..<4,id: \.self){index in
                        
                        TextBoxView(index: index, textBox: $noteList)
                    }
                }
            }
            
            // KeyPad....
            
            
            Text(jawabanSalah ? "Incorrect Answer" : "")
                .foregroundColor(.red)
                .fontWeight(.heavy)
            
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)){
                
                // Password Button ....
                
                ForEach(1...8,id: \.self){value in
                    
                    NoteButton(value: "\(value)",noteTap: $noteList, key: $key, answerOnButton: $jawaban, wrongAnswer: $jawabanSalah)
                }
                
                NoteButton(value: "delete.fill",noteTap: $noteList, key: $key, answerOnButton: $jawaban, wrongAnswer: $jawabanSalah)
                
            }
            .padding()

        }
    }
}

struct TextBoxView : View {
    var index : Int
    @Binding var textBox : String
    
//    var value =
    var body: some View{
        
        ZStack{
            
            Rectangle()
                .frame(width: 77, height: 105)
                .foregroundColor(Color.primaryColor)
                .opacity(0.4)
            
            // checking whether it is typed...
            
            if textBox.count > index{
                ZStack{
                    Rectangle()
                        .frame(width: 77, height: 105)
                        .foregroundColor(Color.blue)
                    
                    Image(textBox)
                        .resizable()
                        .frame(width: 77, height: 105)
                }
                
                
            }
        }
    }
}

struct NoteButton : View {
    var value : String
    @Binding var noteTap : String
    @Binding var key : String
    @Binding var answerOnButton : Bool
    @Binding var wrongAnswer : Bool
    
    
    var body: some View{
        
        Button(action: setButton, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
                else{
                    
                    Image(value)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(10)
                        .border(Color.primaryColor, width: 3)

                }
            }
            .padding()

        })
    }
    
    func setButton(){
        
        // checking if backspace pressed...
        
        withAnimation{
            
            if value.count > 1{
                
                if noteTap.count != 0{
                    
                    noteTap.removeLast()
                }
            }
            else{
                
                if noteTap.count != 4{
                    
                    noteTap.append(value)
                    
                    // Delay Animation...
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        withAnimation{
                            
                            if noteTap.count == 4{
                                
                                if noteTap == key{
                                    
                                    answerOnButton = true
                                }
                                else{
                                    
                                    wrongAnswer = true
                                    noteTap.removeAll()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
