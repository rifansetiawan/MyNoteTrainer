//
//  View+Ext.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 19/08/22.
//

import Foundation
import SwiftUI

extension View {
    func myCustomPopUp(onTapoutside: @escaping () -> Void, withCloseBtn: Bool = false) -> some View {
        modifier(PopupViewModifier(onTapoutside: onTapoutside, withCloseBtn: withCloseBtn))
    }
}



extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

