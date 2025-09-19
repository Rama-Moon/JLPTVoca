import SwiftUI

struct StudyPopupView: View {
    @Binding var isPresented: Bool
    let popupType: PopupType
    
    let completeAction: () -> Void
    let cancelAction: (() -> Void)?

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    if case .studyCompletion = popupType {
                        isPresented = false
                    }
                }
            
            VStack(spacing: 0) {
                popupType.image
                    .resizable()
                    .frame(
                        width: 173,
                        height: 173
                    )
                    .padding(.top, 6)
                    .padding(.bottom, 25)
                
                Text(popupType.title)
                    .font(.b3)
                    .foregroundStyle(Color.black100)
                    .padding(.bottom, 14)
                
                Text(popupType.message)
                    .font(.b4)
                    .foregroundStyle(Color.black50)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                
                HStack(spacing: 25) {
                    if let cancelAction = cancelAction {
                        Button(action: {
                            cancelAction()
                        }) {
                            Text("나가기")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .font(.b2)
                                .foregroundStyle(Color.black70)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                            .stroke(
                                Color.black50,
                                lineWidth: 1
                            )
                        )
                    }
                    
                    Button(action: {
                        completeAction()
                    }) {
                        Text(popupType.primaryButtonTitle)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .font(.b2)
                            .foregroundStyle(Color.white0)
                    }
                    .background(Color.coral50)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    StudyPopupView(
        isPresented: .constant(true),
        popupType: .studyCompletion(studiedCount: 30, uncertainCount: 10),
        completeAction: { print("Primary Action") },
        cancelAction: nil
    )
}
