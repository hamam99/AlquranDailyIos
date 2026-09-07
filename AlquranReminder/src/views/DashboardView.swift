import SwiftUI

struct DashboardView: View {

    var body: some View {
        VStack(spacing: 32) {
            TodayCard()
            AyahTodayCard()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    DashboardView()
}
