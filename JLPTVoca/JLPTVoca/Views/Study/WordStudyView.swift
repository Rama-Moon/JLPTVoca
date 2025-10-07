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
    @Environment(\.modelContext) private var modelContext
    
    @AppStorage("dailyGoal") private var dailyGoal: Int = 20
    @AppStorage("targerLevel") private var selectedLevel: Int = 5
    
    @Query private var reviewableStates: [StudyState]
    @Query private var newWords: [Word]
    
    @State private var sessionDeck: [StudyState] = []
    @State private var totalCardCount: Int = 0
    
    @State private var isPopupPresented: PopupType?
    
    init() {
        let now = Date()
        let reviewPredicate = #Predicate<StudyState> { $0.reviewDate <= now }
        self._reviewableStates = Query(filter: reviewPredicate, sort: \.reviewDate)
        
        let newWordPredicate = #Predicate<Word> { $0.state == nil && $0.jlptLevel == selectedLevel
        }
        var newWordDescriptor = FetchDescriptor<Word>(predicate: newWordPredicate)
        newWordDescriptor.fetchLimit = 20 // TODO: dailyGoal 사용
        self._newWords = Query(newWordDescriptor)
    }
    
    var body: some View {
        ZStack {
            Color.coral50.ignoresSafeArea()
            
            VStack(spacing: 28) {
                WordProgressBar(
                    current: totalCardCount - sessionDeck.count,
                    total: totalCardCount
                )
                .padding(.horizontal, 24)
                
                WordDeckView(deck: $sessionDeck, onSwipe: handleSwipe)
                
                FilterButtons()
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
        .onAppear(perform: setSession)
        .onChange(of: sessionDeck) {_, newDeck in
            if newDeck.isEmpty && totalCardCount > 0 {
                isPopupPresented = .studyCompletion(
                    studiedCount: 30,
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
        guard sessionDeck.isEmpty else { return }
        
        let newStates = newWords.map { word -> StudyState in
            let newState = StudyState(word: word)
            modelContext.insert(newState)
            return newState
        }
        
        let combinedDeck = reviewableStates + newStates
        self.sessionDeck = combinedDeck.shuffled()
        self.totalCardCount = self.sessionDeck.count
    }
    
    private func handleSwipe(state: StudyState, direction: CardSwipeDirection) {
        wordManager.updateStudyState(for: state, direction: direction)
    
        sessionDeck.removeAll { $0.id == state.id }
    }
}
