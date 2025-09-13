//
//  MultiSegmentCircularChart.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//


import SwiftUI

struct MultiSegmentCircularChart: View {
    let chartType: ChartType
    var lineWidth: CGFloat = 12
    
    var body: some View {
        let total = chartType.chartData.reduce(0) { $0 + $1.1 }
        
        var segments: [(String, Int, Color, Double, Double)] = []
        var currentAngle: Double = 0
        
        for item in chartType.chartData {
            let ratio = Double(item.1) / Double(total)
            let angle = ratio * 360
            segments.append((item.0, item.1, item.2, currentAngle, currentAngle + angle))
            currentAngle += angle
        }
        
        return ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
            
            ForEach(Array(segments.enumerated()), id: \.offset) { index, segment in
                Circle()
                    .trim(from: segment.3 / 360, to: segment.4 / 360)
                    .stroke(segment.2, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(chartType.chartData.enumerated()), id: \.offset) { index, item in
                    HStack {
                        Circle()
                            .fill(item.2)
                            .frame(width: 12, height: 12)
                        
                        Text("\(item.0) : \(item.1)")
                            .font(.b5)
                            .foregroundColor(.black50)
                        
                        Spacer()
                    }
                }
            }
            .padding(.leading, 40)
        }
    }
}

#Preview {
    MultiSegmentCircularChart(chartType: .studyOverview)
        .frame(width: 210, height: 210)
}
