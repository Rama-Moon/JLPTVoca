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
                WordProgrssBar(
                    current: 12,
                    total: 40
                )
                .padding(.horizontal, 24)
                
                wordDeckView()
                
                FilterButtons()
            }
            
            if showCompletionModal {
                studyCompletionView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar { customBackButton() }
        .alert(
            "학습 종료",
            isPresented: $showAlert,
            actions: {
                alertButtons
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

extension WordStudyView {
    private func wordDeckView() -> some View {
        ZStack {
            ForEach(wordManager.studyStateDeck) { state in
                WordCardView(
                    id: state.word.id,
                    japanese: state.word.plainJapanese,
                    furigana: state.word.plainFurigana,
                    korean: state.word.korean,
                    koreanExample: state.word.koreanExample,
                    japaneseExample: state.word.japaneseExample
                ) {
                    id, direction in
                    wordManager.onCardSwipe(
                        id: id,
                        direction: direction
                    )
                }
                .frame(
                    width: 345,
                    height: 553
                )
            }
        }
    }
    
    private func studyCompletionView()-> some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            Button(action: {
                router.path.removeLast()
            }) {
                Text("홈으로 돌아가기")
            }
        }
    }
    
    @ToolbarContentBuilder
    private func customBackButton() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showAlert = true
            } label: {
                Image(systemName: "chevron.backward")
            }
        }
    }
    
    @ViewBuilder
    private var alertButtons: some View {
        Button("취소", role: .cancel) { }
        Button("종료", role: .destructive) {
            router.pop()
        }
    }
}
