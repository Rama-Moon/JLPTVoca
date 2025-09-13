//
//  HomeView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(WordManager.self) private var wordManager
    @State private var router = NavigationManager<HomeRoute>()
    
    @State private var selectedLevel: Int = 3
    @State private var isLevelSelectorExpanded: Bool = false
    @State private var isDetailChartEnabled: Bool = false
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack(alignment: .top) {
                Color.orange0.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer().frame(height: 60)
                    
                    SpeechBubbleView()
                    
                    Spacer().frame(height: 8)
                    
                    StudyDashboardView(
                        isDetailChartEnabled: $isDetailChartEnabled,
                        isLevelSelectorExpanded: $isLevelSelectorExpanded
                    )
                    .frame(
                        width: 361,
                        height: 514
                    )
                    
                    StartButtonView()
                        .offset(y: -40)
                    
                    Spacer()
                }

                
                if isLevelSelectorExpanded {
                    Color.black.opacity(0.7)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isLevelSelectorExpanded = false
                            }
                        }
                }
                
                VStack {
                    LevelSelectorView(
                        selectedLevel: $selectedLevel,
                        isLevelSelectorExpanded: $isLevelSelectorExpanded
                    )
                    
                    Spacer()
                }
            }
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .wordStudy:
                    WordStudyView()
                }
            }
        }
        .environment(router)
    }
}

#Preview {
    HomeView()
        .environment(WordManager())
}
