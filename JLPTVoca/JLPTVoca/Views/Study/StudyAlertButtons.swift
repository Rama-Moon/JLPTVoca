import SwiftUI

struct StudyAlertButtons: View {
    @Environment(NavigationManager<HomeRoute>.self) private var router

    var body: some View {
        Button("취소", role: .cancel) { }
        Button("종료", role: .destructive) {
            router.pop()
        }
    }
}

#Preview {
    StudyAlertButtons()
        .environment(NavigationManager<HomeRoute>())
}
