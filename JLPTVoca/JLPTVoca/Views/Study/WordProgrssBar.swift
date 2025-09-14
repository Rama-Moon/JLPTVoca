//
//  WordProgrssBar.swift
//  JLPTVoca
//
//  Created by Rama on 9/15/25.
//

import SwiftUI

struct WordProgrssBar: View {
    let current: Int
    let total: Int
    
    private var progress: Double {
        guard total > 0 else { return 0 }
        return Double(current) / Double(total)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(current)/\(total)")
                    .font(.btn2)
                    .foregroundStyle(Color.black100)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.white40)
                    .cornerRadius(8)
                
                Spacer()
            }
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white40)
                    .frame(height: 10)
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.yellow)
                    .frame(
                        width: progress * UIScreen.main.bounds.width * 0.8,
                        height: 10
                    )
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
    }
}
