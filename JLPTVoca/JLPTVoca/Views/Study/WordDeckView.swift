import SwiftUI

import SwiftUI

struct WordDeckView: View {
    @Binding var deck: [StudyState]
    
    let onSwipe: (StudyState, CardSwipeDirection) -> Void
    
    var body: some View {
        ZStack {
            ForEach(deck) { state in
                WordCardView(
                    id: state.word.id,
                    japanese: state.word.plainJapanese,
                    furigana: state.word.plainFurigana,
                    korean: state.word.korean,
                    koreanExample: state.word.koreanExample,
                    japaneseExample: state.word.japaneseExample
                ) { _, direction in
                    onSwipe(state, direction)
                }
                .frame(width: 345, height: 553)
            }
        }
    }
}
