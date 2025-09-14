//
//  WordCardView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftData
import SwiftUI

struct WordCardView: View {
    @State var offset: CGSize = .zero

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
    }
    
    var body: some View {
        let drag = DragGesture()
            .onChanged { offset = $0.translation }
            .onEnded {
                HapticManager.instance.notification(type: .success)
                
                if $0.translation.width < -100 {
                    offset = .init(width: -1000, height: 0)
                    swiped(id, .left)
                    
                } else if $0.translation.width > 100 {
                    offset = .init(width: 1000, height: 0)
                    swiped(id, .right)
                
                } else {
                    offset = .zero
                }
            }
        
        ZStack {
            Rectangle()
                .foregroundStyle(Color.white0)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack {
                HStack {
                    Image("favouriteIconInactivated")
                        .resizable()
                        .frame(
                            width: 30,
                            height: 30
                        )
                        .padding(24)
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Text("\(furigana)")
                    .font(.wdl)
                    .foregroundStyle(Color.black100)
                
                Text("\(japanese)")
                    .font(.wd)
                    .foregroundStyle(Color.black100)
                
                Text("\(korean)")
                    .font(.btn1)
                    .foregroundStyle(Color.black100)
                
                Text("\(japaneseExample)")
                    .font(.ex)
                    .foregroundStyle(Color.black50)
                    
                Text("\(koreanExample)")
                    .font(.b4)
                    .foregroundStyle(Color.black50)
                
                Spacer()
            }
        }
        .animation(
            .spring(),
            value: offset
        )
        .offset(offset)
        .gesture(drag)
    }
}
