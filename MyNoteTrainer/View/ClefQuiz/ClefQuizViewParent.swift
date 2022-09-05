//
//  ClefQuizViewParent.swift
//  MyNoteTrainer
//
//  Created by Muhammad Rifan Setiawan on 05/09/22.
//

import SwiftUI

struct ClefQuizViewParent: View {
    @State var index : Int = 0
    var body: some View {
        ZStack{
            if index == 0 {
                ClefQuizView(index: $index)
            }
            else if index == 1 {
                ClefQuizView2(index: $index)
            }
            else if index == 2 {
                ClefQuizView3(index: $index)
            }
            
            
        }
        
        
    }
}

struct ClefQuizViewParent_Previews: PreviewProvider {
    static var previews: some View {
        ClefQuizViewParent()
    }
}
