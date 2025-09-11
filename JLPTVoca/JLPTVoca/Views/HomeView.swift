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
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                Color.orange0.ignoresSafeArea()
                
                studyDashboardView()
                
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
                    levelSelector()
                    
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
    
    private func levelSelector() -> some View {
        VStack {
            levelDropdownButton()
            
            if isLevelSelectorExpanded {
                levelButtons()
            }
        }
        .background(isLevelSelectorExpanded ? Color.orange0 : Color.clear)
    }
    
    private func studyDashboardView() -> some View {
        VStack {
            speechBubbleView()
                .frame(width: 233, height: 65)
                .padding(.top, 100)
            
            Spacer()
            
            startButton()
                .padding(.horizontal)
        }
    }
    
    private func speechBubbleView() -> some View {
        Text("단어의 시작은 집중력!")
            .frame(width: 233, height: 65)
            .font(.h1)
            .background(SpeechBubbleShape().fill(Color.white))
    }
    
    private func levelDropdownButton() -> some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                isLevelSelectorExpanded.toggle()
            }
        }){
            HStack {
                Text("JLPT N\(selectedLevel)")
                    .font(.b2)
                    
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isLevelSelectorExpanded ? 180 : 0)) // 180도 회전
                
                Spacer()
            }
            .frame(height: 62)
            .padding(.leading, 20)
            .foregroundStyle(Color.black100)
        }
    }
    
    private func levelButtons() -> some View {
        HStack {
            ForEach((1...5).reversed(), id: \.self) { level in
                Button(action: {
                    selectedLevel = level
                    withAnimation {
                        isLevelSelectorExpanded = false
                    }
                }) {
                    Text("N\(level)")
                        .font(.b2)
                        .foregroundColor(level == selectedLevel ? Color.coral50 : Color.black50)
                }
                .frame(
                    width: 65,
                    height: 65
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(level == selectedLevel ? Color.coral50 : Color.gray,
                            lineWidth: 1
                        )
                )
            }
        }
        .frame(width: .infinity, height: 90)
        .transition(
            .asymmetric(
                insertion: .scale(
                    scale: 0.95,
                    anchor: .top
                ).combined(with: .opacity),
                removal: .opacity.combined(
                    with: .scale(
                        scale: 0.95,
                        anchor: .top
                    )
                )
            )
        )
    }
    
    private func startButton() -> some View {
        Button(action: {
            wordManager.prepareSession()
            router.navigate(.wordStudy)
        }) {
            Text("단어 학습 시작")
                .font(.h1)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    HomeView()
        .environment(WordManager())
}

struct SpeechBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 26
        let tailSize: CGFloat = 10
        
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
    HomeView()
        .environment(WordManager())
}
