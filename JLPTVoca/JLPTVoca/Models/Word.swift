//
//  Word.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import Foundation
import SwiftData

@Model
final class Word: Decodable {
    var id: UUID
    var japanese: [RubyText]
    var korean: String
    var isFavorite: Bool
    var jlptLevel: Int
    var maturityState: Int
    var nextReviewDate: Date
    
    var plainJapanese: String {
        japanese.map { $0.text }.joined()
    }
    
    init(
        japanese: [RubyText],
        korean: String,
        jlptLevel: Int,
        isFavorite: Bool,
        maturityState: Int,
        nextReviewDate: Date
    ) {
        self.id = UUID()
        self.japanese = japanese
        self.korean = korean
        self.jlptLevel = jlptLevel
        self.isFavorite = isFavorite
        self.maturityState = maturityState
        self.nextReviewDate = nextReviewDate
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.japanese = try container.decode([RubyText].self, forKey: .japanese)
        self.korean = try container.decode(String.self, forKey: .korean)
        self.jlptLevel = try container.decode(Int.self, forKey: .jlptLevel)
        
        self.id = UUID()
        self.isFavorite = false
        self.maturityState = 0
        self.nextReviewDate = Date()
    }
}

extension Word {
    enum CodingKeys: String, CodingKey {
        case japanese, korean, jlptLevel
    }
}
