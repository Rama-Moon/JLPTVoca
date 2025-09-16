//
//  DictionaryView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct DictionaryView: View {
    @Environment(WordManager.self) private var wordManager
    
    var body: some View {
        NavigationStack {
            List(wordManager.studyStateDeck) { state in
                VStack(alignment: .leading) {
                    Text(state.word.plainJapanese)
                        .font(.headline)
                    Text(state.word.korean)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("JLPT Dictionary")
        }
    }
}

#Preview {
    DictionaryView()
        .environment(WordManager())
}
