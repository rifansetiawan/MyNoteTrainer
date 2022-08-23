//
//  Extentions.swift
//  quint
//
//  Created by Widya Limarto on 19/05/22.
//

import Foundation
import SwiftUI

extension Color {
    static let bgCoachmark = Color("bgCoachmark")
}


struct MyCustomTapHandler: ViewModifier {
    var onTap: () -> Void
    func body(content: Content) -> some View {
        content
        //Add the onTap to the whole View
        //            .onTapGesture {
        //                myCustomTapHandler()
        //            }
            .gesture(LongPressGesture().onChanged { _ in onTap() })
    }
}

extension View {
    func myCustomTapHandler(callback: @escaping () -> Void) -> some View {
        modifier(MyCustomTapHandler(onTap: callback))
    }
}

func reader(isShowCoachmark: Bool, type: CoachmarkType, coachmarkManager: CoachmarkManager) -> some View {
    return GeometryReader { (geometry) -> AnyView in
        AnyView(CoachmarkView(_frame: geometry.frame(in: CoordinateSpace.global), _size: geometry.size, coachMarkManager: coachmarkManager, isShowCoachmark: isShowCoachmark))
    }
}
