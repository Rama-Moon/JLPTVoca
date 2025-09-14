//
//  CircularProgressView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct CircularProgressView: View {
    let current: Int
    let total: Int
    
    var body: some View {
        var progress: Double { Double(current) / Double(total) }
        var percentage: Int { Int(progress * 100) }
        
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.2),
                    lineWidth: 12
                )
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.coral50,
                    style: StrokeStyle(
                        lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            VStack(spacing: 6) {
                Text("\(percentage)%")
                    .font(.b1)
                    .foregroundStyle(Color.coral50)

                Text("\(current) / \(total)")
                    .font(.b3)
                    .foregroundStyle(Color.black50)
            }
        }
    }
}

#Preview {
    CircularProgressView(current: 1000, total: 3000)
        .frame(width: 210, height: 210)
}
