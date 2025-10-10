//
//  Maturity.swift
//  JLPTVoca
//
//  Created by Rama on 9/21/25.
//

import SwiftUI

enum Maturity: Int, CaseIterable, Codable {
    case unknown = 0
    case new = 1
    case uncertain = 2
    case proficient = 3
    case mastered = 4
    
    var title: String {
        switch self {
        case .unknown:
            return "미학습 단어"
        case .new:
            return "새로 배운 단어"
        case .uncertain:
            return "아직 서툰 단어"
        case .proficient:
            return "숙달된 단어"
        case .mastered:
            return "완전히 외운 단어"
        }
    }
    
    var color: Color {
        switch self {
        case .unknown:
            return .black30
        case .new:
            return .sedano
        case .uncertain:
            return .seotull
        case .proficient:
            return .sukdal
        case .mastered:
            return .coral50
        }
    }
 }
