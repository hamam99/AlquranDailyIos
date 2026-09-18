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
                Text("No last read ayah")
            }
        }
        .task {
            guard let lastRead = quranHelper.getLastReadAyah() else {
                return
            }

            lastReadVerse = TodayVerseModel(
                surahName: lastRead.surahName, surahNumber: lastRead.surahNumber,
                verse: Verse(
                    number: lastRead.surahNumber,
                    text: "",
                    translationEn: "",
                    translationID: ""))
        }
    }

    private func cardContent(for item: TodayVerseModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                Text("LAST READ")
                    .foregroundStyle(Color.primaryContainer).font(.caption)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .frame(alignment: .center)
            .background(Color.primaryFixed, in: RoundedRectangle(cornerRadius: 12))

            Text(item.surahName ?? "")
                .foregroundStyle(.black)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Ayah \(item.verse?.number ?? 0)")
                .foregroundStyle(Color.neutral)
                .font(.default)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button("Continue") {}
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity, alignment: .trailing)

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color.surfaceContainer, in: RoundedRectangle(cornerRadius: 12))

    }
}

#Preview {
    LastReadCard()
}
