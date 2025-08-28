
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
    var dailyWordDeck: [Word] = []
    
    private var context: ModelContext?
    
    func setup(context: ModelContext, words: [Word]) {
        self.context = context
        self.allWords = words
        self.dailyWordDeck = words
    }
    
    func onSwipeLeft(id: UUID) {
        print("memorized")
    }
    
    func onSwipeRight(id: UUID) {
        print("unknown")
    }
}
