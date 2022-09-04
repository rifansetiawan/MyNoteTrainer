//
//  MNLearnView.swift
//  MyNoteTrainer
//
//  Created by Widya Limarto on 04/09/22.
//

import SwiftUI

struct MNLearnView: View {
    var musicalNotes : [[NoteType]] = [[.fullNote, .fullRest], [.halfNote, .halfRest], [.quarterNote, .quarterRest], [.eighthNote, .eighthRest]]
    var songs : [String] = ["whole-not-fix", "half-not-learn-musical", "quarter-not-fix", "eight-not"]
    @State var progressIndex : Int = 0

    
    var body: some View {
        VStack{
            ZStack {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                            .opacity(0.3)
                            .foregroundColor(Color("secondaryColor"))
                        
                        Rectangle().frame(width: CGFloat(Double(self.progressIndex)/Double(musicalNotes.count))*geometry.size.width, height: geometry.size.height)
                            .foregroundColor(Color("secondaryColor"))
                            
                    }
                    .cornerRadius(45.0)
                }
            }.frame(height: 20)
            
            MNLearnContentView(
                vm: MusicalNoteQuizPlayerManager(fileName: songs[progressIndex], ext: "mp3"),
                musicalNote: musicalNotes[progressIndex],
                progressIndex: $progressIndex,
                intervals: countChangeInterval(beat: 8, musicalNote: self.musicalNotes[progressIndex]))
            
        }
        .navigationTitle("Half Note")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func countChangeInterval(beat: Int, musicalNote: [NoteType]) -> [Float] {
        let perBeatInterval = 1.0/Double(beat)
        var intervals : [Float] = [0]
        var index = 0
        var total: Float = 0

        while (total < 1.0) {
            let nextInterval = Float(musicalNote[index].beat.rawValue * perBeatInterval)
            total += nextInterval
            if(total < 1.0) {
                intervals.append(total)
            }
            
            index = index == 0 ? 1 : 0
        }
        print(intervals, musicalNote[0].beat.rawValue)
        return intervals
    }
}

struct MNLearnView_Previews: PreviewProvider {
    static var previews: some View {
        MNLearnView()
    }
}
