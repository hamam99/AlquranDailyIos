import SwiftUI

struct SurahView: View {

    private let quranHelper = QuranHelper()
    @State private var listSurah: [Surah] = []

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(listSurah, id: \.name) { surah in
                            NavigationLink(value: surah) {
                                HStack(spacing: 12) {
                                    Text(String(surah.id)).frame(alignment: .leading)
                                        .foregroundStyle(.white)
                                        .font(.caption)
                                        .frame(width: 32, height: 32)
                                        .background(Color.neutral, in: Circle())
                                    VStack(alignment: .leading) {
                                        Text("\(surah.name)")
                                            .foregroundStyle(Color.onSurface)
                                            .font(.headline)
                                        Text(
                                            "\(surah.nameTranslations.en) • \(surah.numberOfAyah) Ayah"
                                        )
                                        .foregroundStyle(Color.neutral)
                                        .font(.caption)
                                    }
                                    Spacer()
                                    Text(String(surah.nameTranslations.ar)).foregroundStyle(
                                        Color.primary
                                    ).font(.title3)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12).stroke(
                                        Color.neutral, lineWidth: 1))
                            }
                        }
                    }.frame(width: .infinity, alignment: .leading)
                }.padding(12)
            }.task {
                let surah = quranHelper.loadAllSurah()
                listSurah = surah
            }
        }
    }
}

#Preview {
    SurahView()
}
