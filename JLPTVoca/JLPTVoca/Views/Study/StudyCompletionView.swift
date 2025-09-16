import SwiftUI

struct StudyCompletionView: View {
    @Environment(NavigationManager<HomeRoute>.self) private var router

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            Button(action: {
                router.path.removeLast()
            }) {
                Text("홈으로 돌아가기")
            }
        }
    }
}

#Preview {
    StudyCompletionView()
        .environment(NavigationManager<HomeRoute>())
}
