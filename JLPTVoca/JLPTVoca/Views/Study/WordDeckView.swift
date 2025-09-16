import SwiftUI

struct WordDeckView: View {
    @Environment(WordManager.self) private var wordManager

    var body: some View {
        ZStack {
            ForEach(wordManager.studyStateDeck) { state in
                WordCardView(
                    id: state.word.id,
                    japanese: state.word.plainJapanese,
                    furigana: state.word.plainFurigana,
                    korean: state.word.korean,
                    koreanExample: state.word.koreanExample,
                    japaneseExample: state.word.japaneseExample
                ) { id, direction in
                    wordManager.onCardSwipe(id: id, direction: direction)
                }
                .frame(width: 345, height: 553)
            }
        }
    }
}

#Preview {
    WordDeckView()
        .environment(WordManager())
}
