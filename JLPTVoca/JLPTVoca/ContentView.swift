//
//  ContentView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var words: [Word]
    @Environment(\.modelContext) private var context
    @State private var wordManager = WordManager()
    
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
        .environment(wordManager)
        .onAppear() {
            wordManager.setContext(context: context)
        }
    }
}
