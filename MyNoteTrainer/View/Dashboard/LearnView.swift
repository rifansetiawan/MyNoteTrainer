//
//  LearnView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 18/08/22.
//

import SwiftUI

struct LearnView: View {
    var image = ["MusicalNote", "Clef", "MusicScale"]
    var title = ["Musical Notes", "Clef", "Scale"]
    var lesson = ["4 Lessons", "4 Lessons", "4 Lessons"]
    var level = ["Beginner", "Beginner", "Intermediate"]
    var body: some View {
        NavigationView{
            List(0..<title.count) { index in
                
                ZStack{
//                    Rectangle()
//                        .frame(width: 345, height: 105, alignment: .center)
//                        .foregroundColor(Color.white)
                    HStack{
                        Image(self.image[index])
                        VStack{
                            Text(self.title[index])
                                .font(.system(size: 16, weight: .semibold))
//                                .frame(width: 145, height: 16, alignment: .leading)
                            
                            HStack{
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color.green)
                                Text(self.level[index])
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(Color.gray)
                                
                            }
//                            .frame(width: 145, height: 16, alignment: .leading)
                            
                            HStack{
                                Image(systemName: "book")
                                    .foregroundColor(Color.gray)
                                Text(self.lesson[index])
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(Color.gray)
                            }
//                            .frame(width: 145, height: 16, alignment: .leading)
                        }
                    }
//                    .frame(width: 345, height: 105, alignment: .leading)
                    
                }
            }
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
