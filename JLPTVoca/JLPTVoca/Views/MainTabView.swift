//
//  MainTabView.swift
//  JLPTVoca
//
//  Created by Rama on 9/21/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("학습", systemImage: "house.fill")
                }
            
            SelectDictionaryView()
                .tabItem {
                    Label("사전", systemImage: "book.fill")
                }
            
            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gearshape.fill")
                }
        }
    }
}
