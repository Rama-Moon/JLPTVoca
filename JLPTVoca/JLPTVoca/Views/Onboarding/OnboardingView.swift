//
//  OnboardingView.swift
//  JLPTVoca
//
//  Created by Rama on 9/21/25.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    
    @AppStorage("targetLevel") private var targetLevel: Int = 5
    @AppStorage("dailyGoal") private var dailyGoal: Int = 20
    @AppStorage("targetDate") private var targetDate: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("목표를 설정하고\n학습을 시작해 보세요!")
                .font(.largeTitle.bold())
                .padding(.top, 50)
            
            levelSelector()
            
            goalStepper()
            
            datePicker()
            
            Spacer()
            
            Button(action: {
                hasCompletedOnboarding = true
            }) {
                Text("학습 시작하기")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(30)
    }
    
    private func levelSelector() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("목표 급수")
                .font(.headline)
            HStack(spacing: 10) {
                ForEach(1...5, id: \.self) { level in
                    Button(action: {
                        targetLevel = level
                    }) {
                        Text("N\(level)")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(targetLevel == level ? Color.accentColor :
                                            Color.black.opacity(0.05))
                            .foregroundColor(targetLevel == level ? .white :
                                    .primary)
                            .cornerRadius(8)
                            .animation(.spring, value: targetLevel)
                    }
                }
            }
        }
    }
    
    private func goalStepper() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("하루 목표 암기 개수")
                .font(.headline)
            HStack {
                Text("\(dailyGoal)개")
                    .font(.title2.bold())
                Spacer()
                Button(action: {
                    if dailyGoal > 5 { dailyGoal -= 5 }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color.accentColor.opacity(0.8))
                }
                Button(action: {
                    dailyGoal += 5
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color.accentColor)
                }
            }
            .padding()
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
        }
    }
    
    private func datePicker() -> some View {
        DatePicker(
            "목표 시험일",
            selection: $targetDate,
            in: Date()..., // 과거 날짜는 선택할 수 없도록 설정
            displayedComponents: .date
        )
        .font(.headline)
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}

