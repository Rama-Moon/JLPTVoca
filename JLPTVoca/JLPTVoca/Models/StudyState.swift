//
//  StudyState.swift
//  JLPTVoca
//
//  Created by Rama on 9/2/25.
//

import SwiftUI
import SwiftData

@Model
final class StudyState {
    @Relationship var word: Word
    
    var maturityState: Int = 0
    var reviewDate: Date = Date()
    var isFavorite: Bool = false
    
    init(word: Word) {
        self.word = word
    }
}
