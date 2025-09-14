//
//  LevelSelectorView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct LevelSelectorView: View {
    @Binding var selectedLevel: Int
    @Binding var isLevelSelectorExpanded: Bool
    
    let onLevelSelected: (Int) -> Void
    
    var body: some View {
        VStack {
            levelDropdownButton()
            
            if isLevelSelectorExpanded {
                levelButtons()
            }
        }
        .background(isLevelSelectorExpanded ? Color.orange0 : Color.clear)
    }
    
    private func levelDropdownButton() -> some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                isLevelSelectorExpanded.toggle()
            }
        }){
            HStack {
                Text("JLPT N\(selectedLevel)")
                    .font(.b2)
                    
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isLevelSelectorExpanded ? 180 : 0)) // 180도 회전
                
                Spacer()
            }
            .frame(height: 62)
            .padding(.leading, 20)
            .foregroundStyle(Color.black100)
        }
    }
    
    private func levelButtons() -> some View {
        HStack {
            ForEach((1...5).reversed(), id: \.self) { level in
                Button(action: {
                    onLevelSelected(level)
                }) {
                    Text("N\(level)")
                        .font(.b2)
                        .foregroundStyle(level == selectedLevel ? Color.coral50 : Color.black50)
                }
                .frame(
                    width: 65,
                    height: 65
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(level == selectedLevel ? Color.coral50 : Color.gray,
                            lineWidth: 1
                        )
                )
            }
        }
        .frame(
            width: .infinity,
            height: 90
        )
        .transition(
            .asymmetric(
                insertion: .scale(
                    scale: 0.95,
                    anchor: .top
                ).combined(
                    with: .opacity
                ),
                removal: .opacity.combined(
                    with: .scale(
                        scale: 0.95,
                        anchor: .top
                    )
                )
            )
        )
    }
}
