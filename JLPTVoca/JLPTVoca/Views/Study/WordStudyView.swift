//
//  WordStudyView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftData
import SwiftUI

struct WordStudyView: View {
    @Environment(WordManager.self) private var wordManager
    @Environment(NavigationManager<HomeRoute>.self) private var router
    
    @State private var isPopupPresented: PopupType?
    
    var body: some View {
        ZStack {
            Color.coral50.ignoresSafeArea()
            
            VStack(spacing: 28) {
                WordProgressBar(
                    current: 12,
                    total: 40
                )
                .padding(.horizontal, 24)
                
                WordDeckView()
                
                FilterButtons()
            }
            
            if let popupType = isPopupPresented {
                StudyPopupView(
                    isPresented: Binding(
                        get: { isPopupPresented != nil },
                        set: { if !$0 { isPopupPresented = nil } }
                    ),
                    popupType: popupType,
                    completeAction: { router.pop() },
                    cancelAction: popupType == .exitConfirmation ? { isPopupPresented = nil } : nil
                )
            }
        }

        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isPopupPresented = .exitConfirmation
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
        .onChange(of: wordManager.studyStateDeck) {
            _,
            newDeck in
            if newDeck.isEmpty {
                isPopupPresented = .studyCompletion(
                    studiedCount: 30,
                    uncertainCount: 10
                )
            }
        }
    }
}
