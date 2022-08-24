
//
//  QuizView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 20/08/22.
//

import SwiftUI

struct QuizView: View {
    
    var body: some View {
        
        NavigationView{
            ZStack{
                MusicalQuiz()
            }
            .navigationTitle("Musical Note")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

struct MusicalQuiz : View {
    var quizes : [MusicalNoteQuizModel] = MusicalNoteQuizModel.quizes
    @State var quizIndex: Int = 0
    
    
    var body: some View{
        
        VStack {
            Text("\(quizIndex)")
            ZStack{
                
                
                NoteQuiz(quiz: quizes[quizIndex], goToNextQuiz: {
                    if(quizes.count-1 > quizIndex) {
                        self.quizIndex += 1
                    }
                    
                })
            }
        }
    }
}

struct NoteQuiz: View {
    var quiz: MusicalNoteQuizModel
    var goToNextQuiz: () -> ()
    @State var noteList = ""
    @AppStorage("jawaban") var key = "1223"
    @State var jawaban : Bool = false
    @State var jawabanSalah = false
    @State private var playAudio: Bool = false
    
    
    
    let height = UIScreen.main.bounds.width
    
    var buttons: [Note] = [
        Note(noteType: .fullNote, sound: Sound(tone: .F)),
        Note(noteType: .halfNote, sound: Sound(tone: .F)),
        Note(noteType: .quarterNote, sound: Sound(tone: .F)),
        Note(noteType: .eighthNote, sound: Sound(tone: .F)),
        Note(noteType: .fullRest, sound: Sound(tone: .F)),
        Note(noteType: .halfRest, sound: Sound(tone: .F)),
        Note(noteType: .quarterRest, sound: Sound(tone: .F)),
        Note(noteType: .eighthNote, sound: Sound(tone: .F))
    ]
    
    @State var answerList: [Note] = []
    
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
                    
                    ForEach(answerList,id: \.id){note in
                        Image(note.noteType.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
//                        TextBoxView(index: index, textBox: $noteList)
                    }
                }
            }
            
            
            Text(jawabanSalah ? "Incorrect Answer" : "")
                .foregroundColor(.red)
                .fontWeight(.heavy)
            
            //buttonn start
            Button {
                self.playAudio.toggle()
            } label: {
                Image(playAudio ? "pause" : "play")
                    .resizable()
                    .frame(width: 85, height: 85)
            }
            .padding()
            
            // animasi panjang lagu
            ZStack{
                Capsule()
                    .fill(Color.purple)
                    .frame(width: playAudio ? 0 : 300, height: 5)
                // .animation(.linear(duration: lamaLagu))
                
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.purple)
                    .offset(x: playAudio ? -150 : 150)
                // .animation(.linear(duration: lamaLagu))
            }
            
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)){
                
                // Note Button ....
                
                ForEach(buttons,id: \.id){note in
                    
                    NoteButton(note: note, onTap: onTapButton,value: "\(123)",noteTap: $noteList, key: $key, answerOnButton: $jawaban, wrongAnswer: $jawabanSalah)
                }
                
                
                
            }
            .padding()
            
        }
    }
    func onTapButton(note: Note) {
        
        if(answerList.count < 4) {
            answerList.append(note)
        }
        
        if(answerList.count == 4) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                var success = true
                for (index, i) in quiz.answer.enumerated() {
                    if(i.beat != answerList[index].noteType.beat || i.isRest != answerList[index].noteType.isRest){
                       success = false
                        break;
                    }
                }
                if(success) {
                    self.jawaban = true
                    self.answerList = []
                    self.goToNextQuiz()
                } else {
                    answerList.removeAll()
                }
            })
            
        
        }
        //check with answer quiz
            
        
        
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
                        .foregroundColor(Color.primaryColor)
                    
                    Image(textBox)
                        .resizable()
                        .frame(width: 77, height: 105)
                }
                
                
            }
        }
    }
}

struct NoteButton : View {
    var note: Note
    var onTap: (_ note: Note) -> ()
    var value : String
    @Binding var noteTap : String
    @Binding var key : String
    @Binding var answerOnButton : Bool
    @Binding var wrongAnswer : Bool
    
    
    var body: some View{
        
        Button(action: {
            onTap(note)
        }, label: {
            
            VStack{
                Image(note.noteType.image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .border(Color.primaryColor, width: 3)
            
            }
            .padding(5)
            
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
