
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
        VStack(spacing: 10) {
            ForEach(rubyTexts, id: \.self) { rubyText in
                if let furigana = rubyText.furigana {
                    Text(furigana)
                        .font(.wdl)
                        .foregroundStyle(Color.black100)
                    
                    Text(rubyText.text)
                        .font(.wd)
                        .foregroundStyle(Color.black100)
                } else {
                    Text(rubyText.text)
                        .font(.wd)
                        .foregroundStyle(Color.black100)
                }
            }
        }
    }
}
