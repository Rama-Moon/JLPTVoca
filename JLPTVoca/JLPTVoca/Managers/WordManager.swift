
//
//  WordManager.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI
import SwiftData

@Observable
final class WordManager {
    var allWords: [Word] = []
    var wordDeck: [Word] = []
    
    private var context: ModelContext?
    
    func setup(
        context: ModelContext,
        words: [Word]
    ) {
        self.context = context
        self.allWords = words
    }
    
    func prepareSession() {
        self.wordDeck = allWords
    }
    
    func onCardSwipe(
        id: UUID,
        direction: CardSwipeDirection
    ) {
        guard let swipedWord = allWords.first(where: { $0.id == id }) else {
            return
        }

        if direction == .left {
            swipedWord.maturityState += 1
        } else {
            swipedWord.maturityState = 1
        }

        wordDeck.removeAll { $0.id == id }

        if wordDeck.isEmpty {
            do {
                try context?.save()
            } catch {
                print("@Log - \(error.localizedDescription)")
            }
        }
    }
}
