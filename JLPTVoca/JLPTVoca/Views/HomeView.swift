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
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 20) {
                Button(action: {
                    wordManager.prepareSession()
                    router.navigate(.wordStudy)
                }) {
                    Text("단어 학습 시작")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("JLPT-VOCA")
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
