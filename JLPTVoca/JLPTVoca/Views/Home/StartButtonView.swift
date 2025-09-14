//
//  StartButtonView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct StartButtonView: View {
    @Environment(WordManager.self) private var wordManager
    @Environment(NavigationManager<HomeRoute>.self) private var router
    
    var body: some View {
        Button(action: {
            wordManager.prepareSession()
            router.navigate(.wordStudy)
        }) {
            HStack {
                Image(.bookIcon)
                    .resizable()
                    .frame(
                        width: 27,
                        height: 27
                    )
                
                Text("단어 외우러 가기")
                    .font(.h1)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 55)
            .padding(.vertical, 28)
            .background(Color.coral50)
            .cornerRadius(50)
        }
    }
}

#Preview {
    StartButtonView()
        .environment(WordManager())
        .environment(NavigationManager<HomeRoute>())
}
