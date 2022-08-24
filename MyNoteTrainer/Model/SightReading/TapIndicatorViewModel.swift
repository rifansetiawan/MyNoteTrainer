//
//  TapIndicatorViewModel.swift
//  MyNoteTrainer
//
//  Created by Widya Limarto on 23/08/22.
//

import Foundation


class TapIndicatorViewModel: ObservableObject {
    @Published var tapIndicatorState: TapIndicatorState = .neutral
    
    func changeState(state: TapIndicatorState){
        self.tapIndicatorState = state
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tapIndicatorState = .neutral
        }
    }
}
