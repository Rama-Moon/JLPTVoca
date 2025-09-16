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
    var jlptLevel: Int
    var koreanExample: String
    var japaneseExample: String
    
    var plainJapanese: String {
        japanese.map { $0.text }.joined()
    }
    
    var plainFurigana: String {
        japanese.compactMap{ $0.furigana }.joined()
    }
    
    @Relationship(inverse: \StudyState.word)
    
    var state: StudyState?
    
    init(
        japanese: [RubyText],
        korean: String,
        jlptLevel: Int,
        koreanExample: String,
        japaneseExample: String
    ) {
        self.id = UUID()
        self.japanese = japanese
        self.korean = korean
        self.jlptLevel = jlptLevel
        self.koreanExample = koreanExample
        self.japaneseExample = japaneseExample
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.japanese = try container.decode([RubyText].self, forKey: .japanese)
        self.korean = try container.decode(String.self, forKey: .korean)
        self.jlptLevel = try container.decode(Int.self, forKey: .jlptLevel)
        self.koreanExample = try container.decode(String.self, forKey: .koreanExample)
        self.japaneseExample = try container.decode(String.self, forKey: .japaneseExample)
        
        self.id = UUID()
    }
}

extension Word {
    enum CodingKeys: String, CodingKey {
        case japanese, korean, jlptLevel, koreanExample, japaneseExample
    }
}
