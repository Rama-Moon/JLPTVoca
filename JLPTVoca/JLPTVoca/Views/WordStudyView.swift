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
    
    var body: some View {
        ZStack {
            ForEach(wordManager.dailyWordDeck) { word in
                WordCardView(
                    id: word.id,
                    japanese: word.plainJapanese,
                    korean: word.korean
                ) { id, direction in
                    if direction == .left {
                        wordManager.onSwipeLeft(id: id)
                    } else {
                        wordManager.onSwipeRight(id: id)
                    }
                }
            }
        }
    }
}

#Preview {
    WordStudyView()
}
