//
//  SpeechBubbleView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct SpeechBubbleView: View {
    var body: some View {
        Text("단어의 시작은 집중력!")
            .frame(width: 233, height: 65)
            .font(.h1)
            .background(SpeechBubbleShape().fill(Color.white))
    }
}

struct SpeechBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 15
        let tailSize: CGFloat = 15
        let mainPath = Path(roundedRect: rect, cornerRadius: cornerRadius)
        
        var tailPath = Path()
        
        tailPath.move(to: CGPoint(x: rect.midX - tailSize, y: rect.maxY))
        tailPath.addLine(to: CGPoint(x: rect.midX, y: rect.maxY + tailSize))
        tailPath.addLine(to: CGPoint(x: rect.midX + tailSize, y: rect.maxY))
        
        var combinedPath = Path()
        
        combinedPath.addPath(mainPath)
        combinedPath.addPath(tailPath)
        
        return combinedPath
    }
}


#Preview {
    SpeechBubbleView()
}
