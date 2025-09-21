//
//  DictionaryWordCard.swift
//  JLPTVoca
//
//  Created by Rama on 9/20/25.
//

import SwiftUI

struct DictionaryWordCard: View {
    @State private var isFavorited = false
    
    var japanese: String
    var furigana: String
    var korean: String
    var level: Int
    var maturity: Int
    var isFavorite: Bool
    
    var body: some View {
        Button(action: { }) {
            HStack {
                wordContent()
                Spacer()
                wordInfo()
            }
            .padding(12)
        }
    }
    
    private func wordContent() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(japanese)")
                    .font(.wdl)
                    .foregroundStyle(Color.black100)
                    .padding(.trailing, 12)
                
                Text("\(furigana)")
                    .font(.furi)
                    .foregroundStyle(Color.black50)
            }
            .padding(.bottom, 8)
            
            Text("\(korean)")
                .font(.b4)
                .foregroundStyle(Color.black100)
        }
    }
    
    private func wordInfo() -> some View {
        VStack(alignment: .trailing, spacing: 12) {
            HStack {
                Text("N\(level)")
                    .font(.min)
                    .foregroundStyle(Color.black70)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.cyan)
                        .frame(width: 8, height: 8)
                    
                    Text("\(maturity)")
                        .font(.min)
                        .foregroundStyle(Color.black70)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            
            Spacer().frame(height: 12)
            
            FavoriteButton(
                isFavorited: isFavorited,
                action: { })
        }
    }
}
