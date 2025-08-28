//
//  HomeView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(WordManager.self) private var wordManager
    
    var body: some View {
        Text("Home View")
    }
}

#Preview {
    HomeView()
        .environment(WordManager())
}
