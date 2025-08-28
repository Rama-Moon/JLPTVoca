//
//  SettingView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(WordManager.self) private var wordManager
    
    var body: some View {
        Text("Setting View")
    }
}

#Preview {
    SettingView()
        .environment(WordManager())
}
