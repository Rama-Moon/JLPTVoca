//
//  LayoutConstants.swift
//  JLPTVoca
//
//  Created by Rama on 9/14/25.
//

import Foundation

enum Drag {
    static let swipeThreshold: CGFloat = 150
    static let velocityThreshold: CGFloat = 500
    static let rotationDivider: CGFloat = 20
    static let opacityDivider: CGFloat = 300
    static let scaleDivider: CGFloat = 2000
    static let maxOpacityReduction: Double = 0.5
    static let swipeAnimationDistance: CGFloat = 1000
    static let swipeAnimationDelay: Double = 0.3
    static let swipeAnimationResponse: Double = 0.5
    static let swipeAnimationDamping: Double = 0.8
    static let returnAnimationResponse: Double = 0.6
    static let returnAnimationDamping: Double = 0.8
    static let animationBlendDuration: Double = 0
    static let colorFeedbackThreshold: CGFloat = 50
    static let overlayOpacityMax: Double = 1.0
    static let hintScaleMax: CGFloat = 1.2
}
