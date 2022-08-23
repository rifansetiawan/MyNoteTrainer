//
//  TapIndicatorState.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 23/08/22.
//

import Foundation
import SwiftUI

enum TapIndicatorState {
    case neutral
    case green
    case red
    
    var color: Color {
        switch(self) {
        case .neutral:
            return .primaryColor
        case .green:
            return .greenColor
        case .red:
            return .redColor
        }
    }
}
