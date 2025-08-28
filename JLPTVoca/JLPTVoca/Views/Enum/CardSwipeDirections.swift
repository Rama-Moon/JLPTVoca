//
//  CardSwipeType.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import Foundation

enum CardSwipeDirection {
    case left
    case right
}

typealias CardSwipe = (
    _ id: UUID,
    _ direction: CardSwipeDirection
) -> Void
