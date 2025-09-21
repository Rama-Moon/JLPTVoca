//
//  WordCardView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftData
import SwiftUI

struct WordCardView: View {
    @StateObject private var dragHandler: CardDragHandler
    @State private var isRevealed = false
    @State private var isFavorited = false

    let swiped: CardSwipe
    
    var id: UUID
    var japanese: String
    var furigana: String
    var korean: String
    var koreanExample: String
    var japaneseExample: String
    
    init(
        id: UUID,
        japanese: String,
        furigana: String,
        korean: String,
        koreanExample: String,
        japaneseExample: String,
        swiped: @escaping CardSwipe = {_, _ in }
    ) {
        self.id = id
        self.japanese = japanese
        self.furigana = furigana
        self.korean = korean
        self.koreanExample = koreanExample
        self.japaneseExample = japaneseExample
        self.swiped = swiped
        
        self._dragHandler = StateObject(
            wrappedValue: CardDragHandler(
                cardId: id,
                onSwipe: swiped
            )
        )
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.white0)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            RoundedRectangle(cornerRadius: 16)
                .fill(dragHandler.overlayColor)
                .opacity(dragHandler.overlayOpacity)
            
            HStack {
                if dragHandler.swipeDirection == .left {
                    Spacer()
                    
                    VStack(spacing: 60) {
                        Image(.catSad)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.white)
                            .scaleEffect(dragHandler.hintScale)
                        
                        Text("학습할게요")
                            .font(.h1)
                            .foregroundStyle(Color.black100)
                    }

                } else if dragHandler.swipeDirection == .right {
                    VStack(spacing: 60) {
                        Image(.catHappy)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.white)
                            .scaleEffect(dragHandler.hintScale)
                        
                        Text("알고있어요")
                            .font(.h1)
                            .foregroundStyle(Color.black100)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 40)
            .opacity(dragHandler.overlayOpacity * 3)
            
            VStack {
                HStack {
                    FavoriteButton(
                        isFavorited: isFavorited,
                        action: { })
                    .padding(24)
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            VStack(spacing: 10) {
                Spacer()
                
                if isRevealed {
                    Text("\(furigana)")
                        .font(.wdl)
                        .foregroundStyle(Color.black100)
                }
                
                Text("\(japanese)")
                    .font(.wd)
                    .foregroundStyle(Color.black100)
                
                if isRevealed {
                    Text("\(korean)")
                        .font(.btn1)
                        .foregroundStyle(Color.black100)
                        .padding(.top, 10)
                }
                
                Text("\(japaneseExample)")
                    .font(.ex)
                    .foregroundStyle(Color.black50)
                    .padding(.top, 20)
                    
                if isRevealed {
                    Text("\(koreanExample)")
                        .font(.b4)
                        .foregroundStyle(Color.black50)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .opacity(1.0 - dragHandler.swipeIntensity)
        }
        .scaleEffect(dragHandler.dragScale)
        .rotationEffect(.degrees(dragHandler.dragAngle))
        .animation(
            .interactiveSpring(response: 0.4, dampingFraction: 0.8, blendDuration: 0),
            value: dragHandler.offset
        )
        .offset(dragHandler.offset)
        .gesture(dragHandler.dragGesture)
        .onTapGesture {
            withAnimation(.spring()) {
                isRevealed.toggle()
            }
        }
    }
}
