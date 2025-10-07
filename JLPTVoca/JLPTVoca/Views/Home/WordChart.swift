//
//  WordChart.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct WordChart: View {
    let studiedCount: Int
    let totalCount: Int
    
    var body: some View {
        var progress: Double { Double(studiedCount) / Double(totalCount) }
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

                Text("\(studiedCount) / \(totalCount)")
                    .font(.b3)
                    .foregroundStyle(Color.black50)
            }
        }
    }
}
