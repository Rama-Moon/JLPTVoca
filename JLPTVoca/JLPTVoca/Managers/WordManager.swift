//
//  WordManager.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI
import SwiftData
import OSLog

@Observable
final class WordManager {
    var studyStateDeck: [StudyState] = []
    
    private var context: ModelContext?
    
    func setContext(context: ModelContext) {
        self.context = context
    }
    
    func prepareSession() {
        guard context != nil else { return }
        
        let reviewableStates = fetchReviewableStates()
        let newWords = fetchNewWords(limit: 20) //TODO: RawVal 수정, 사용자 학습 목표량으로 수정
        let newWordStates = createStates(for: newWords)
        
        self.studyStateDeck = (reviewableStates + newWordStates).shuffled()
    }
    
    private func fetchData<T: PersistentModel>(with descriptor: FetchDescriptor<T>) -> [T] {
        guard let context else { return [] }
        
        do {
            return try context.fetch(descriptor)
        } catch {
            print("@Log - \(error.localizedDescription)")
            return []
        }
    }
    
    private func fetchReviewableStates() -> [StudyState] {
        let now = Date()
        let predicate = #Predicate<StudyState> { $0.reviewDate <= now }
        let descriptor = FetchDescriptor<StudyState>(predicate: predicate)
        
        return fetchData(with: descriptor)
    }
    
    func fetchNewWords(limit: Int) -> [Word] {
        let predicate = #Predicate<Word> { $0.state == nil }
        var descriptor = FetchDescriptor<Word>(predicate: predicate)
        descriptor.fetchLimit = limit
        
        return fetchData(with: descriptor)
    }
    
    private func createStates(for words: [Word]) -> [StudyState] {
        guard let context else { return [] }
        
        return words.map { newWord in
            let newState = StudyState(word: newWord)
            context.insert(newState)
            return newState
        }
    }
    
    func onCardSwipe(
        id: UUID,
        direction: CardSwipeDirection
    ) {
        guard let swipedState = studyStateDeck.first(where: { $0.word.id == id }) else {
            return
        }
        
        if direction == .left {
            swipedState.maturityState = min(swipedState.maturityState + 1, 5)
        } else {
            swipedState.maturityState = 1
        }
        updateNextReviewDate(for: swipedState)
        studyStateDeck.removeAll { $0.word.id == id }
        
        if studyStateDeck.isEmpty {
            do {
                try context?.save()
            } catch {
                print("@Log - \(error.localizedDescription)")
            }
        }
    }
    
    func updateNextReviewDate(for state: StudyState) {
        let now = Date()
        let secondsInDay: TimeInterval = 86400
        var interval: TimeInterval = 0
        
        switch state.maturityState {
        case 1:
            interval = secondsInDay * 1
        case 2:
            interval = secondsInDay * 3
        case 3:
            interval = secondsInDay * 7
        case 4:
            interval = secondsInDay * 14
        case 5:
            interval = secondsInDay * 30
        default:
            state.reviewDate = now
            return
        }
        
        state.reviewDate = now.addingTimeInterval(interval)
    }
}
