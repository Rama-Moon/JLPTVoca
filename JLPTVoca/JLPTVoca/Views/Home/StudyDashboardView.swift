//
//  StudyDashboardView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI
import SwiftData

struct ChartData: Identifiable {
    let id = UUID()
    let label: String
    let count: Int
    let color: Color
}


struct StudyDashboardView: View {
    let selectedLevel: Int
    
    @Binding var isDetailChartEnabled: Bool
    @Binding var isLevelSelectorExpanded: Bool
    
    @AppStorage("targetDate") private var targetDate: Date = Date()
    @AppStorage("dailyGoal") private var dailyGoal: Int = 5
    
    @Query private var words: [Word]
    
    init(
        selectedLevel: Int,
        isDetailChartEnabled: Binding<Bool>,
        isLevelSelectorExpanded: Binding<Bool>
    ) {
        self.selectedLevel = selectedLevel
        self._isDetailChartEnabled = isDetailChartEnabled
        self._isLevelSelectorExpanded = isLevelSelectorExpanded
        
        let predicate = #Predicate<Word> { $0.jlptLevel == selectedLevel}
        self._words = Query(filter: predicate)
    }
    
    private var dDay: Int {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfTargetDay = calendar.startOfDay(for: targetDate)
        let components = calendar.dateComponents(
            [.day],
            from: startOfToday,
            to: startOfTargetDay
        )
        
        return components.day ?? 0
    }
    
    private var totalCount: Int {
        words.count
    }
    
    private var studiedCount: Int {
        words.filter { ($0.state?.maturityState ?? 0) > 0 }.count
    }
    
    private var maturityCounts: [Maturity: Int] {
        let groupedByMaturity = Dictionary(grouping: words) {
            let rawValue = $0.state?.maturityState ?? 0
            
            return Maturity(rawValue: rawValue) ?? .unknown
        }
        
        return groupedByMaturity.mapValues { $0.count }
    }
    
    private var chartData: [ChartData] {
        return Maturity.allCases.map { maturityLevel in
            let count = maturityCounts[maturityLevel] ?? 0
            return ChartData(
                label: maturityLevel.title,
                count: count,
                color: maturityLevel.color
            )
        }
    }
    
    var body: some View {
        ZStack {
            Image(.dashboardBackground)
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 26) {
                Spacer().frame(height: 110)
                
                DDayCard(dDay: dDay)
                
                if isDetailChartEnabled {
                    DetailedWordChart(data: chartData)
                        .frame(width: 210, height: 210)
                    
                } else {
                    WordChart(studiedCount: studiedCount, totalCount: totalCount)
                        .frame(width: 210, height: 210)
                }
                
                ChartToggleButton(isDetailChartEnabled: $isDetailChartEnabled)
                
                Spacer()
            }
        }
    }
}
