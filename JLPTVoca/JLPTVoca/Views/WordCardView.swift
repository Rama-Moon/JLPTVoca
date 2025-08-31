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
    var korean: String
    
    init(
        id: UUID,
        japanese: String,
        korean: String,
        swiped: @escaping CardSwipe = {_, _ in }
    ) {
        self.id = id
        self.japanese = japanese
        self.korean = korean
        self.swiped = swiped
    }
    
    var body: some View {
        let drag = DragGesture()
            .onChanged { offset = $0.translation }
            .onEnded {
                HapticManager.instance.notification(type: .success)
                
                if $0.translation.width < -100 { //TODO: RawVal 수정
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
                .fill(.blue)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack {
                Spacer()
                
                Group {
                    Text("\(japanese)")
                        .font(.largeTitle)
                    Text("\(korean)")
                        .font(.headline)
                }
                .foregroundStyle(.white)
                
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
