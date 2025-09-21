//
//  DictionaryView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct DictionaryView: View {
    @Environment(WordManager.self) private var wordManager
    
    let type: DictionaryType
    
    var body: some View {
        DictionaryWordCard(
            japanese: "四字熟語",
            furigana: "よじじゅくご",
            korean: "사자성어",
            level: 111,
            maturity: 2222222,
            isFavorite: true
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15)
            .stroke(
                Color.black50,
                lineWidth: 1
            ))
    }
}
