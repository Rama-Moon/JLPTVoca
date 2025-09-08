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
            VStack {
                wordDeckView()
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
                Text("7년 연습생 하고 집에 갈래?") //TODO: RawVal 수정
            })
        .onChange(of: wordManager.wordDeck) { _, newDeck in
            if newDeck.isEmpty {
                showCompletionModal = true
            }
        }
    }
}

extension WordStudyView {
    private func wordDeckView() -> some View {
        ZStack {
            ForEach(wordManager.wordDeck) { word in
                WordCardView(
                    id: word.id,
                    japanese: word.plainJapanese,
                    korean: word.korean
                ) {
                    id, direction in
                    wordManager.onCardSwipe(
                        id: id,
                        direction: direction
                    )
                }
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
