//
//  StudyDashboardView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI
import SwiftData

struct StudyDashboardView: View {
    @Binding var isDetailChartEnabled: Bool
    @Binding var isLevelSelectorExpanded: Bool
    
    var body: some View {
        ZStack {
            Image(.dashboardBackground)
                .resizable()
                .scaledToFit()
            
            VStack {
                Spacer().frame(height: 136)
                
                DDayView(dDay: 20)
                
                Spacer().frame(height: 26)
                
                if isDetailChartEnabled {
                    MultiSegmentCircularChart(chartType: .studyOverview)
                        .frame(
                            width: 210,
                            height: 210
                        )
                    
                } else {
                    CircularProgressView(
                        current: 1000,
                        total: 3000
                    )
                    .frame(
                        width: 210,
                        height: 210
                    )
                }
                
                Spacer().frame(height: 26)
                
                ChartToggleButton(isDetailChartEnabled: $isDetailChartEnabled)
                
                Spacer()
            }
        }
    }
}
