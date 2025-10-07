//
//  ContentView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @AppStorage("isDataPreloaded") private var isDataPreloaded: Bool = false
    @Environment(WordManager.self) private var wordManager
    
    var body: some View {
        Group {
            if !hasCompletedOnboarding {
                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
            } else if !isDataPreloaded {
                ProgressView("단어 데이터를 준비 중입니다..")
            } else {
                MainTabView()
            }
        }
        .onAppear {
            wordManager.prepareInitialData()
        }
    }
}
