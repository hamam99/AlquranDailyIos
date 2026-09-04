import SwiftUI

struct TodayCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Assalamu Alaikum").font(.title).foregroundStyle(.primary).bold()
            Text(getTodayDate()).font(.caption).foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }

    private func getTodayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .islamicUmmAlQura)
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy G"

        let today = dateFormatter.string(from: Date())
        return today
    }
}
