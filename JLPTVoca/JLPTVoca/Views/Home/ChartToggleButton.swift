//
//  ChartToggleButton.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import SwiftUI

struct ChartToggleButton: View {
    @Binding var isDetailChartEnabled: Bool
    
    var body: some View {
        Button(action: {
            isDetailChartEnabled.toggle()
        }){
            Text(isDetailChartEnabled ? "세부 차트 ON" : "세부 차트 OFF")
                .font(.btn2)
                .foregroundStyle(isDetailChartEnabled ? Color.white : Color.black50)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(isDetailChartEnabled ? Color.coral50 : Color.black10)
                .cornerRadius(20)
        }
    }
}

#Preview {
    @Previewable @State var isEnabled = false
    return ChartToggleButton(isDetailChartEnabled: $isEnabled)
}
