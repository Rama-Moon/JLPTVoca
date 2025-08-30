//
//  HomeView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(WordManager.self) private var wordManager
    
    @State private var isStudyViewActive = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                NavigationLink(
                    destination: WordStudyView(),
                    isActive: $isStudyViewActive
                ) {
                    EmptyView()
                }
                
                Button(action: {
                    wordManager.prepareSession()
                    isStudyViewActive = true
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
            .navigationTitle("홈")
        }
    }
}

#Preview {
    HomeView()
        .environment(WordManager())
}
