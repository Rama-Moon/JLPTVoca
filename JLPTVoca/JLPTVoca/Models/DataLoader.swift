
//
//  DataLoader.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import Foundation
import SwiftData

struct DataLoader {
    static func loadInitialData(context: ModelContext) {
        let descriptor = FetchDescriptor<Word>()
        
        guard let count = try? context.fetchCount(descriptor), count == 0 else {
            print("@Log - Data Exists")
            return
        }
        
        guard let url = Bundle.main.url(forResource: "words", withExtension: "json") else {
            fatalError("@Log - Can't find file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("@Log - Can't load file")
        }
        
        do {
            let words = try JSONDecoder().decode([Word].self, from: data)
            
            for word in words {
                context.insert(word)
            }
            print("@Log - Initial data loading complete")
        } catch {
            fatalError("\(error)")
        }
    }
}
