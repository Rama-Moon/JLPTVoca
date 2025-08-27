
//
//  RubyTextView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct RubyTextView: View {
    let rubyTexts: [RubyText]

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(rubyTexts, id: \.self) { rubyText in
                if let furigana = rubyText.furigana {
                    VStack(spacing: 2) {
                        Text(furigana)
                            .font(.caption)
                        Text(rubyText.text)
                            .font(.title)
                    }
                    .padding(.horizontal, 1)
                } else {
                    Text(rubyText.text)
                        .font(.title)
                }
            }
        }
    }
}
