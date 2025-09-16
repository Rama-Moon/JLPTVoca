//
//  CardDragHandler.swift
//  JLPTVoca
//
//  Created by Rama on 9/16/25.
//

import SwiftUI

class CardDragHandler: ObservableObject {
    @Published var offset: CGSize = .zero
    
    private let onSwipe: (UUID, CardSwipeDirection) -> Void
    private let cardId: UUID
    
    init(cardId: UUID, onSwipe: @escaping (UUID, CardSwipeDirection) -> Void) {
        self.cardId = cardId
        self.onSwipe = onSwipe
    }
    
    var dragAmount: CGFloat {
        sqrt(offset.width * offset.width + offset.height * offset.height)
    }
    
    var dragAngle: Double {
        Double(offset.width / Drag.rotationDivider)
    }
    
    var dragScale: Double {
        1.0 - dragAmount / Drag.scaleDivider
    }
    
    var swipeDirection: SwipeHint {
        if abs(offset.width) < Drag.colorFeedbackThreshold {
            return .none
        }
        return offset.width > 0 ? .right : .left
    }

    var swipeIntensity: Double {
        let intensity = abs(offset.width) / Drag.swipeThreshold
        return min(intensity, 1.0)
    }

    var overlayOpacity: Double {
        swipeIntensity * Drag.overlayOpacityMax
    }
    
    var hintScale: CGFloat {
        1.0 + (swipeIntensity * (Drag.hintScaleMax - 1.0))
    }
    
    var overlayColor: Color {
        switch swipeDirection {
        case .left:
            return .coral30
        case .right:
            return .seotull
        case .none:
            return .clear
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                self.offset = value.translation
            }
            .onEnded { [weak self] value in
                self?.handleDragEnd(value)
            }
    }
    
    private func handleDragEnd(_ value: DragGesture.Value) {
        HapticManager.instance.notification(type: .success)
        
        if shouldSwipeLeft(value) {
            animateSwipeLeft(value)
        } else if shouldSwipeRight(value) {
            animateSwipeRight(value)
        } else {
            animateReturn()
        }
    }
    
    private func shouldSwipeLeft(_ value: DragGesture.Value) -> Bool {
        value.translation.width < -Drag.swipeThreshold ||
        value.predictedEndTranslation.width < -Drag.velocityThreshold
    }
    
    private func shouldSwipeRight(_ value: DragGesture.Value) -> Bool {
        value.translation.width > Drag.swipeThreshold ||
        value.predictedEndTranslation.width > Drag.velocityThreshold
    }
    
    private func animateSwipeLeft(_ value: DragGesture.Value) {
        withAnimation(
            .spring(
                response: Drag.swipeAnimationResponse,
                dampingFraction: Drag.swipeAnimationDamping,
                blendDuration: Drag.animationBlendDuration
            )
        ) {
            offset = .init(
                width: -Drag.swipeAnimationDistance,
                height: value.translation.height
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Drag.swipeAnimationDelay) {
            self.onSwipe(self.cardId, .left)
        }
    }
    
    private func animateSwipeRight(_ value: DragGesture.Value) {
        withAnimation(
            .spring(
                response: Drag.swipeAnimationResponse,
                dampingFraction: Drag.swipeAnimationDamping,
                blendDuration: Drag.animationBlendDuration
            )
        ) {
            offset = .init(
                width: Drag.swipeAnimationDistance,
                height: value.translation.height
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Drag.swipeAnimationDelay) {
            self.onSwipe(self.cardId, .right)
        }
    }
    
    private func animateReturn() {
        withAnimation(
            .spring(
                response: Drag.returnAnimationResponse,
                dampingFraction: Drag.returnAnimationDamping,
                blendDuration: Drag.animationBlendDuration
            )
        ) {
            offset = .zero
        }
    }
}
