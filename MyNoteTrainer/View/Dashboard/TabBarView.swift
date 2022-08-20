//
//  TabBarView.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 18/08/22.
//

import SwiftUI

struct TabBarFixedNew: View {
    
//    @State var connect: DashboardView = DashboardView(isShowPopup: false)
    @State private var tabSelection = 1

    
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                DashboardView()
                    .tabItem {
                        Image(systemName: "book.closed.fill")
                        Text("Learn")
                    }
                    .tag(1)
                
                PracticeView()
                    .tabItem {
                        Image(systemName: "music.note")
                        Text("Practice")
                    }
                    .tag(2)
                
                SettingView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                    .tag(3)
            }
            
            .accentColor(Color(#colorLiteral(red: 0.3679022491, green: 0.761993885, blue: 0.884503603, alpha: 1)))
            // global, for all child views
            
            .navigationBarTitle(Text(navigationBarTitle), displayMode: .large)
//            .navigationBarHidden(connect.isShowPopup)
        }

    }
        
}

struct TabBarFixedNew_Previews: PreviewProvider {
    static var previews: some View {
        TabBarFixedNew()
    }
}


private extension TabBarFixedNew {
    var navigationBarTitle: String {
        if (tabSelection == 1){
            return "Learn"
        }else if(tabSelection == 2){
            return "Practice"
        }else {
            return "Settings"
        }
    }
}
