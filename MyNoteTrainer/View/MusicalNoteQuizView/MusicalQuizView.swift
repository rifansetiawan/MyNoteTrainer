
//
//  QuizView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 20/08/22.
//

import SwiftUI

struct QuizView: View {
    @State var isShowTutorial: Bool = true
    var body: some View {
        
        NavigationView{
            ZStack{
                MusicalQuiz()
                if(isShowTutorial) {
                    MusicalNoteQuizTutorial()
                }
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

struct MusicalNoteQuizTutorial: View {
    @State var step: Int = 0
    var body: some View{
        ZStack{
            if(step == 0) {
                VStack {
                    
                }
            }
        }
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

enum NoteAnswerState {
    case correct
    case wrong
    case empty
    
    var color: Color {
        switch(self){
        case .correct:
            return .primary40Color
        case .wrong:
            return .red40Color
        case .empty:
            return .primary40Color
        }
    }
}

struct NoteQuiz: View {
    var quiz: MusicalNoteQuizModel
    var goToNextQuiz: () -> ()
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
                    ForEach(0..<4,id: \.self){i in
                        ZStack{
                            Rectangle()
                                .frame(width: 77, height: 80)
                                .foregroundColor(
                                    (i <= answerList.count - 1) && answerList.count == 4 ? checkAnswer(i: i).color : .primary40Color
                                )
                            
                            if(i <= answerList.count - 1 ) {
                                Image(answerList[i].noteType.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
            
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
                ForEach(buttons,id: \.id){note in
                    NoteButton(note: note, onTap: onTapButton)
                }
            }
            .padding()
            
        }
    }
    
    func checkAnswer(i: Int) -> NoteAnswerState {
        if(quiz.answer[i].beat != answerList[i].noteType.beat || quiz.answer[i].isRest != answerList[i].noteType.isRest) {
            return .wrong
        } else {
            return .correct
        }
    }
    
    func onTapButton(note: Note) {
        print(answerList.count)
        if(answerList.count < 4) {
            answerList.append(note)
        }
        
        if(answerList.count == 4) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                var success = true
                print(answerList.count, quiz.answer.count)
                for (index, i) in quiz.answer.enumerated() {
                    if(i.beat != answerList[index].noteType.beat || i.isRest != answerList[index].noteType.isRest){
                        success = false
                        break;
                    }
                }
                if(success) {
                    self.answerList = []
                    self.goToNextQuiz()
                } else {
                    answerList.removeAll()
                }
            })
        }
    }
}


struct NoteButton : View {
    var note: Note
    var onTap: (_ note: Note) -> ()
    
    
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
}
