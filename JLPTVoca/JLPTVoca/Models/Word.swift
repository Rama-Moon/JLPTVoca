//
//  Word.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import Foundation
import SwiftData

@Model
final class Word {
   var id: UUID
   var japanese: String
   var korean: String
   var furigana: String
   var isFavorite: Bool
   var jlptLevel: Int
   var maturityState: Int
   var nextReviewDate: Date
   
   init(
       japanese: String,
       korean: String,
       furigana: String,
       jlptLevel: Int,
       isFavorite: Bool = false,
       maturityState: Int = 0,
       nextReviewDate: Date = Date()
   ) {
       self.id = UUID()
       self.japanese = japanese
       self.korean = korean
       self.furigana = furigana
       self.jlptLevel = jlptLevel
       self.isFavorite = isFavorite
       self.maturityState = maturityState
       self.nextReviewDate = nextReviewDate
   }
}
