//
//  FilterButtons.swift
//  JLPTVoca
//
//  Created by Rama on 9/15/25.
//

import SwiftUI

struct FilterButtons: View {
    var body: some View {
        HStack(spacing: 15) {
            filterButton(text: "학습할게요")
            filterButton(text: "알고 있어요")
        }
    }
    
    func filterButton(text: String) -> some View {
        Button(action: { }){
            Text("\(text)")
                .font(.b3)
                .foregroundStyle(Color.black100)
                .padding(.horizontal, 45)
                .padding(.vertical, 25)
                .background(Color.white40)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
