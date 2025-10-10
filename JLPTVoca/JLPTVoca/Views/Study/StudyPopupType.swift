//
//  StudyPopupType.swift
//  JLPTVoca
//
//  Created by Rama on 9/18/25.
//

import SwiftUI

enum PopupType: Equatable {
    case exitConfirmation
    case studyCompletion(
        studiedCount: Int = 0,
        uncertainCount: Int = 0
    )
    
    var title: String {
        switch self {
        case .exitConfirmation:
            return "학습을 중단할까요?"
        case .studyCompletion(_, _):
            return "오늘의 단어 학습을 마쳤어요!"
        }
    }
    
    var image: Image {
        switch self {
        case .exitConfirmation:
            return Image(.catSad)
        case .studyCompletion(_, _):
            return Image(.catHappy)
        }
    }

    var message: String {
        switch self {
        case .exitConfirmation:
            return "지금 중단하면 학습한 내용이 저장되지 않아요"
        case .studyCompletion(let studiedCount, let uncertainCount):
            return "외운 단어: \(studiedCount)\n학습할 단어: \(uncertainCount)"
        }
    }
}
