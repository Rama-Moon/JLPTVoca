//
//  WordStudyView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftData
import SwiftUI

struct WordStudyView: View {
    @AppStorage("targetLevel") private var selectedLevel: Int = 5
    @AppStorage("dailyGoal") private var dailyGoal: Int = 5
    
    @Environment(WordManager.self) private var wordManager
    @Environment(NavigationManager<HomeRoute>.self) private var router
    @Environment(\.modelContext) private var modelContext
    
    // reviewDate가 있는 모든 StudyState 가져옴
    @Query var reviewableStates: [StudyState]
    
    // 학습한 적 없는 모든 Word를 가져옴
    @Query(filter: #Predicate<Word> { $0.state == nil })
    private var newWords: [Word]
    
    @State private var sessionDeck: [StudyState] = []
    @State private var totalCardCount: Int = 0
    @State private var isPopupPresented: PopupType?
    @State private var sessionContext: ModelContext?
    
    var body: some View {
        ZStack {
            Color.coral50.ignoresSafeArea()
            
            if let sessionContext {
                VStack(spacing: 28) {
                    WordProgressBar(
                        current: totalCardCount - sessionDeck.count,
                        total: totalCardCount
                    )
                    .padding(.horizontal, 24)
                    
                    WordDeckView(deck: $sessionDeck, onSwipe: handleSwipe)
                        .environment(\.modelContext, sessionContext)
                    
                    FilterButtons()
                }
            }
            
            if let popupType = isPopupPresented {
                StudyPopupView(
                    isPresented: Binding(
                        get: { isPopupPresented != nil },
                        set: { if !$0 { isPopupPresented = nil } }
                    ),
                    popupType: popupType,
                    completeAction: { router.pop() },
                    cancelAction: popupType == .exitConfirmation ? { isPopupPresented = nil } : nil
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if sessionContext == nil {
                self.sessionContext = ModelContext(modelContext.container)
            }
            setSession()
        }
        .onChange(of: sessionDeck) {_, newDeck in
            if newDeck.isEmpty && totalCardCount > 0 {
                do {
                    try sessionContext?.save()
                    print("@Log - Session completed and saved")
                } catch {
                    print("@Log - Failed to save session: \(error)")
                }
                
                isPopupPresented = .studyCompletion(
                    studiedCount: totalCardCount,
                    uncertainCount: 10
                )
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isPopupPresented = .exitConfirmation
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
    
    private func setSession() {
        guard sessionDeck.isEmpty,
              let context = sessionContext else { return }

        let now = Date()

        // 복습 단어 필터링
        let reviewStatesForSession = reviewableStates.filter {
            $0.word.jlptLevel == selectedLevel &&
            $0.reviewDate != nil &&
            $0.reviewDate! <= now
        }
        
        // 새로운 단어 필터링
        let newWordsForSession = newWords
            .filter { $0.jlptLevel == selectedLevel }
            .prefix(dailyGoal)
        
        // 세션 시작 시, sessionContext에만 StudyState를 미리 생성
        let newStatesForSession = newWordsForSession.map { word ->
            StudyState in
            let newState = StudyState(word: word)
            context.insert(newState)
            return newState
        }

        let combinedDeck = newStatesForSession + reviewStatesForSession
        self.sessionDeck = combinedDeck.shuffled()
        self.totalCardCount = self.sessionDeck.count
    }
    
    private func handleSwipe(state: StudyState, direction: CardSwipeDirection) {
        wordManager.updateStudyState(
            for: state,
            direction: direction,
            shouldSave: false
        )
        sessionDeck.removeAll { $0.id == state.id }
    }
}

