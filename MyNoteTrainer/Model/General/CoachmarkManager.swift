//
//  CoachmarkManager.swift
//  quint
//
//  Created by Widya Limarto on 20/05/22.
//

import Foundation
import UIKit
import SwiftUI


struct Coachmark {
    var image: String?
    var description: String
}

class CoachmarkManager: ObservableObject {
    
    var coachmarkData : [Coachmark]
    @Published var coachmarkIndex : Int = 0
    
    init(coachmarkData: [Coachmark]) {
        self.coachmarkData = coachmarkData
        //check localstorage
        coachmarkIndex = 0
        
    }
    
    func nextCoachmark() {
        guard coachmarkData.count > coachmarkIndex else { return }
        coachmarkIndex += 1
//        UserDefaults.standard.set(coachmarkIndex as Int, forKey: "\(coachmarkType)-coachmark")
    }
}

func reader(isShowCoachmark: Bool, coachmarkManager: CoachmarkManager) -> some View {
    return GeometryReader { (geometry) -> AnyView in
        AnyView(CoachmarkView(_frame: geometry.frame(in: CoordinateSpace.global), _size: geometry.size, coachMarkManager: coachmarkManager, isShowCoachmark: isShowCoachmark))
    }
}
