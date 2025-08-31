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
    
    var body: some View {
        wordDeckView()
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

#Preview {
    WordStudyView()
}
