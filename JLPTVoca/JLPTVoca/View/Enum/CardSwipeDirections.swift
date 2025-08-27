//
//  CardSwipeType.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import Foundation

enum CardSwipeDirections {
    case left
    case right
}

typealias CardSwipe = (
    _ id: UUID,
    _ direction: CardSwipeDirections
) -> Void
