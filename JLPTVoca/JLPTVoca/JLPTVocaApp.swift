//
//  JLPTVocaApp.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI
import SwiftData

@main
struct JLPTVocaApp: App {
    let sharedModelConatainer: ModelContainer
    let wordManager: WordManager
    
    init() {
        let container = try! ModelContainer(for: Word.self, StudyState.self)
        self.sharedModelConatainer = container
        self.wordManager = WordManager(modelContainer: container)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelConatainer)
        .environment(wordManager)
    }
}
