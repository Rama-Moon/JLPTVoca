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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Word.self, onSetup: { result in
            switch result {
            case .success(let container):
                DataLoader.loadInitialData(context: container.mainContext)
            case .failure(let error):
                fatalError("\(error.localizedDescription)")
            }
        })
    }
}
