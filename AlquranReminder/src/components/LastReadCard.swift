import SwiftData
import SwiftUI

struct LastReadCard: View {
    @State private var lastReadVerse: TodayVerseModel? = nil

    let quranHelper = QuranHelper()
    var body: some View {
        Group {
            if let lastReadVerse {
                NavigationLink(value: lastReadVerse) {
                    cardContent(for: lastReadVerse)
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 120, alignment: .center)
            }
        }
        .task {

            // lastReadVerse = TodayVerseModel(surahName: , surahNumber: Int?, verse: Verse?)
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
    LastReadCard()
}
