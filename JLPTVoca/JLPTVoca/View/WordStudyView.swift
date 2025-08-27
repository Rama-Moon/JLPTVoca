//
//  WordStudyView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftData
import SwiftUI

struct WordStudyView: View {
    @Query(filter: #Predicate<Word> { word in
        word.jlptLevel == 2
    }) private var words: [Word]
    
    var body: some View {
        ZStack {
            ForEach(words) { word in
                WordCardView(
                    id: word.id,
                    japanese: word.plainJapanese,
                    korean: word.korean
                ) { id, direction in
                    if direction == .left {
                        onSwipeLeft()
                    } else {
                        onSwipeRight()
                    }
                }
            }
        }
    }
}

extension WordStudyView {
    func onSwipeLeft() {
        //TODO: 외웠을 때 액션
        print("memorized")
    }
    
    func onSwipeRight() {
        //TODO: 외웠을 때 액션
        print("unknown")
    }
}

#Preview {
    WordStudyView()
}
