//
//  WordStudyView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftData
import SwiftUI

struct WordStudyView: View {
    @Environment(WordManager.self) private var wordManager
    @Environment(NavigationManager<HomeRoute>.self) private var router
    
    @State private var showAlert = false
    @State private var showCompletionModal = false
    
    var body: some View {
        ZStack {
            Color.coral50.ignoresSafeArea()
            
            VStack(spacing: 28) {
                WordProgressBar(
                    current: 12,
                    total: 40
                )
                .padding(.horizontal, 24)
                
                WordDeckView()
                
                FilterButtons()
            }
            
            if showCompletionModal {
                StudyCompletionView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar { CustomBackButton(showAlert: $showAlert) }
        .alert(
            "학습 종료",
            isPresented: $showAlert,
            actions: {
                StudyAlertButtons()
            }, message: {
                Text("7년 연습생 하고 집에 갈래?")
            })
        .onChange(of: wordManager.studyStateDeck) { _, newDeck in
            if newDeck.isEmpty {
                showCompletionModal = true
            }
        }
    }
}
