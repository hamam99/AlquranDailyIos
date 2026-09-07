import SwiftUI

struct AyahTodayCard: View {
    @State private var todayVerse: TodayVerseModel? = nil

    let quranHelper = QuranHelper()
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "sparkles")
                Text("AYAH OF THE DAY")
                    .foregroundStyle(Color.primaryContainer).font(.caption)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(alignment: .center)
            .background(Color.primaryFixed, in: RoundedRectangle(cornerRadius: 12))

            Text(todayVerse?.verse?.text ?? "")
                .foregroundStyle(.black)
                .font(.title2)
                .multilineTextAlignment(.trailing)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text(todayVerse?.verse?.translationEn ?? "")
                .foregroundStyle(Color.neutral)
                .font(.default)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(
                "\(todayVerse?.surahName ?? "") [\(todayVerse?.surahNumber ?? ""):\(todayVerse?.verse?.number.description ?? "")]"
            )
            .foregroundStyle(Color.secondary)
            .font(.caption)
            .bold()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.surfaceContainer, in: RoundedRectangle(cornerRadius: 12))
        .task {
            todayVerse = quranHelper.getTodayVerse()
        }
    }
}

#Preview {
    AyahTodayCard()
}
