//
//  DDayView.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct DDayView: View {
    let dDay: Int
    
    var body: some View {
        Text("다음 시험일까지 D-\(dDay)")
            .font(.b3)
            .foregroundStyle(Color.coral50)
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
            .background(Color.orange20)
            .cornerRadius(12)
    }
}

#Preview {
    DDayView(dDay: 20)
}
