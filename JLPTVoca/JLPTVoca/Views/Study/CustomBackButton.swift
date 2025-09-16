import SwiftUI

struct CustomBackButton: ToolbarContent {
    @Binding var showAlert: Bool

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showAlert = true
            } label: {
                Image(systemName: "chevron.backward")
            }
        }
    }
}
