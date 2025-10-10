//
//  WordManager.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI
import SwiftData

@Observable
@MainActor
final class WordManager {
    let modelContainer: ModelContainer
    
    private var mainContext: ModelContext {
        modelContainer.mainContext
    }
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    func prepareInitialData() {
        let isPreloaded = UserDefaults.standard.bool(forKey: "isDataPreloaded")
        guard !isPreloaded else { return }
        
        Task(priority: .background) {
            do {
                guard let url = Bundle.main.url(forResource: "words", withExtension: "json") else {
                    print("@Log - Failed to find json file")
                    return
                }
                let data = try Data(contentsOf: url)
                let words = try JSONDecoder().decode([Word].self, from: data)
                
                let backgroundContext = ModelContext(modelContainer)
                
                for word in words {
                    backgroundContext.insert(word)
                }
                
                try backgroundContext.save()
                
                await MainActor.run {
                    UserDefaults.standard.set(true, forKey: "isDataPreloaded")
                    print("@Log - Preload succeed")
                }
            } catch {
                print("@Log - Failed to preload")
            }
        }
    }
    
    func updateStudyState(
        for state: StudyState,
        direction: CardSwipeDirection,
        shouldSave: Bool = true
    ) {
        if direction == .left {
            state.maturityState = 1
        } else {
            state.maturityState = min(state.maturityState + 1, 5)
        }
        
        updateNextReviewDate(for: state)
        
        do {
            try mainContext.save()
        } catch {
            print("@Log - Failed to save context")
        }
    }
    
    func updateNextReviewDate(for state: StudyState) {
        let now = Date()
        let secondsInDay: TimeInterval = 86400
        var interval: TimeInterval = 0
        
        switch state.maturityState {
        case 1:
            interval = secondsInDay * 1
        case 2:
            interval = secondsInDay * 3
        case 3:
            interval = secondsInDay * 7
        case 4:
            interval = secondsInDay * 14
        case 5:
            interval = secondsInDay * 30
        default:
            state.reviewDate = now
            return
        }
        
        state.reviewDate = now.addingTimeInterval(interval)
    }
}
