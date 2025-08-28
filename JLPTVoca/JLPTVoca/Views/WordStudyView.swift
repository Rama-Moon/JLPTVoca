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
}

#Preview {
    WordStudyView()
}
