import SwiftUI

struct DashboardView: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                TodayCard()
                AyahTodayCard()
            }
            .navigationDestination(
                for: TodayVerseModel.self,
                destination: { item in
                    SurahAyahView(
                        surah: Surah(
                            name: item.surahName ?? "",
                            numberOfSurah: item.surahNumber
                        ),
                        todayVerse: item
                    )
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    DashboardView()
}
