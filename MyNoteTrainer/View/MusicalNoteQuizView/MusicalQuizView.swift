
//
//  QuizView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 20/08/22.
//

import SwiftUI

struct MusicalQuizView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var quizes : [MusicalNoteQuizModel] = MusicalNoteQuizModel.quizes
    @State var isShowTutorial: Bool = true
    @State var quizIndex: Int = 0
    
    @State var isShowSuccessPopUp: Bool = false
    var body: some View {
        
            ZStack{
                VStack {
                    HStack(alignment: .center) {
                        Text("Guess the right Note based on the audio")
                            .font(.system(size: 24, weight: .semibold))
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                    }
                    .padding()
                    ZStack{
                        NoteQuiz(
                            quiz: quizes[quizIndex],
                            goToNextQuiz: {
                            
                            self.isShowSuccessPopUp = true
                            
                            },
                            vm: MusicalNoteQuizPlayerManager(fileName: quizes[quizIndex].song, ext: "mp3"))
                        
                    }
                }
                if(isShowTutorial) {
                    MusicalNoteQuizTutorial()
                }
                if(isShowSuccessPopUp) {
                    PopUpCorrectQuizView(onPressPrimary: quizIndex < quizes.count-1 ? ({
                        if(quizes.count-1 > quizIndex) {
                            self.quizIndex += 1
                        }
                        isShowSuccessPopUp = false
                    }) : nil, onPressSecondary: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    .myCustomPopUp()
                }
                
            }
            .navigationTitle("Musical Note")
            .navigationBarTitleDisplayMode(.inline)
            
    }
}

struct MusicalQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MusicalQuizView()
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
    @ObservedObject var vm : MusicalNoteQuizPlayerManager
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
        Note(noteType: .eighthRest, sound: Sound(tone: .F))
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
                        ZStack(alignment: .bottom){
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
//                                    .background(.green)
                                    .offset(x: 0, y: -5)
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
                HStack{
                    Capsule()
                        .fill(Color.purple)
                        .frame(width: 300 * CGFloat(vm.playbackProgress), height: 5, alignment: .leading)
                }.frame(width: 300, alignment: .leading)
                
                // .animation(.linear(duration: lamaLagu))
                
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.purple)
                    .offset(x: 300 * CGFloat(vm.playbackProgress) + 150 * -1)
                // .animation(.linear(duration: lamaLagu))
            }
            
            
            VStack{
                HStack{
                    ForEach(0..<4,id: \.self){i in
                        NoteButton(note: buttons[i], onTap: onTapButton)
                    }
                }
                HStack{
                    ForEach(4..<8,id: \.self){i in
                        NoteButton(note: buttons[i], onTap: onTapButton)
                    }
                }
            }
            .padding()
        }
        .onChange(of: quiz.id, perform: { i in
            answerList.removeAll()
        })
        .onChange(of: playAudio, perform: { i in
            if(i) {
                vm.play()
            } else {
                vm.stop()
            }
        })
        .onChange(of: vm.isPlaying, perform: {i in
                self.playAudio = i
        })
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
            var success = true
            print(answerList.count, quiz.answer.count)
            for (index, i) in quiz.answer.enumerated() {
                if(i.beat != answerList[index].noteType.beat || i.isRest != answerList[index].noteType.isRest){
                    success = false
                    break;
                }
            }
            if(success) {
                self.goToNextQuiz()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    answerList.removeAll()
                })
                
            }
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
