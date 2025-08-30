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
            List(wordManager.allWords) { word in
                VStack(alignment: .leading) {
                    Text(word.plainJapanese)
                        .font(.headline)
                    Text(word.korean)
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
