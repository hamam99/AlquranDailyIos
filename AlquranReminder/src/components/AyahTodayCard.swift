import SwiftUI

struct AyahTodayCard: View {
    @State private var todayVerse: TodayVerseModel? = nil

    let quranHelper = QuranHelper()
    var body: some View {
        Group {
            if let todayVerse {
                NavigationLink(value: todayVerse) {
                    cardContent(for: todayVerse)
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 120, alignment: .center)
            }
        }
        .task {
            todayVerse = quranHelper.getTodayVerse()
        }
    }

    private func cardContent(for item: TodayVerseModel) -> some View {
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

            Text(item.verse?.text ?? "")
                .foregroundStyle(.black)
                .font(.title2)
                .multilineTextAlignment(.trailing)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text(item.verse?.translationEn ?? "")
                .foregroundStyle(Color.neutral)
                .font(.default)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(
                "\(item.surahName ?? "") [\(item.surahNumber.map(String.init) ?? ""):\(item.verse?.number.description ?? "")]"
            )
            .foregroundStyle(Color.secondary)
            .font(.caption)
            .bold()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.surfaceContainer, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    AyahTodayCard()
}
