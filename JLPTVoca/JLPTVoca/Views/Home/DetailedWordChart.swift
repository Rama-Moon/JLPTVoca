//
//  DetailedWordChart.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//


import SwiftUI


struct DetailedWordChart: View {
    let data: [ChartData]
    var lineWidth: CGFloat = 12
    
    var body: some View {
        let total = data.reduce(0) { $0 + $1.count }
        
        guard total > 0 else {
            return AnyView(
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
            )
        }
        
        var startAngle: Double = 0
        let segments = data.map { item -> (data: ChartData, range: Range<Double>) in
            let ratio = Double(item.count) / Double(total)
            let angle = ratio * 360
            let endAngle = startAngle + angle
            let range = startAngle..<endAngle
            startAngle = endAngle
            return (item, range)
        }
        
        return AnyView(ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
            
            ForEach(segments, id: \.data.id) { (item, angleRange) in
                Circle()
                    .trim(from: angleRange.lowerBound / 360, to: angleRange.upperBound
                          / 360)
                    .stroke(item.color, style: StrokeStyle(lineWidth: lineWidth,
                                                           lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(data) { item in
                    HStack {
                        Circle()
                            .fill(item.color)
                            .frame(width: 12, height: 12)
                        
                        Text("\(item.label) : \(item.count)")
                            .font(.b5)
                            .foregroundColor(.black50)
                        
                        Spacer()
                    }
                }
            }
            .padding(.leading, 40)
        })
    }
}
