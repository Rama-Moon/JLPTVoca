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
    @State private var pendingLevel: Int?
    @State private var isLevelSelectorExpanded = false
    @State private var isDetailChartEnabled = false
    @State private var isAlertPresented = false
    
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
                        isLevelSelectorExpanded: $isLevelSelectorExpanded,
                        onLevelSelected: { level in
                            if level != selectedLevel {
                                self.pendingLevel = level
                                self.isAlertPresented = true
                            } else {
                                withAnimation {
                                    isLevelSelectorExpanded = false
                                }
                            }
                        }
                    )
                    
                    Spacer()
                }
            }
            .alert("레벨을 변경할까요?", isPresented: $isAlertPresented) {
                Button("돌아가기", role: .cancel) { }
                Button("변경하기") {
                    if let newLevel = pendingLevel {
                        selectedLevel = newLevel
                    }
                    withAnimation {
                        isLevelSelectorExpanded = false
                    }
                }
            } message: {
                Text("진행 중인 학습 내용은 그대로 유지돼요!")
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
