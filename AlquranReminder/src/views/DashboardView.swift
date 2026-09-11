import SwiftUI

struct DashboardView: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                TodayCard()
                AyahTodayCard()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .navigationDestination(
                for: TodayVerseModel.self,
                destination: { item in
                    SurahAyahView(
                        surah: Surah(
                            name: item.surahName ?? "",
                            numberOfSurah: item.surahNumber,
                            id: item.surahNumber
                        ),
                        todayVerse: item
                    )
                }
            )
        }
    }
}

#Preview {
    DashboardView()
}
