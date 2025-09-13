//
//  ChartType.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

enum ChartType {
    case studyOverview

    var chartData: [(String, Int, Color)] {
        switch self {
        case .studyOverview:
            return [
                ("완전히 외운 단어", 340, .coral50),
                ("숙달된 단어", 160, .sukdal),
                ("아직 서툰 단어", 225, .seotull),
                ("새로 배운 단어", 411, .sedano),
                ("미학습 단어", 1375, .black50)
            ]
        }
    }
}
