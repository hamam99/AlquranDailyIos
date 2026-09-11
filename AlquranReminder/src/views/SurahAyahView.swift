import SwiftUI

struct SurahAyahView: View {
	var surah: Surah
	var quranHelper = QuranHelper()
	var todayVerse: TodayVerseModel? = nil

	@State private var surahAyah: SurahAyahModel? = nil
	@State private var scrollPosition: Int?

	var body: some View {
		ZStack {
			ScrollView {
				LazyVStack(spacing: 8) {
					ForEach(surahAyah?.verses ?? [], id: \.number) { verse in
						VStack {
							HStack(alignment: .top, spacing: 12) {
								Text(String(verse.number))
									.frame(width: 32, height: 32)
									.foregroundStyle(.white)
									.font(.caption)
									.background(Color.neutral, in: Circle())

								Text(verse.text)
									.foregroundStyle(.black)
									.font(.title2)
									.multilineTextAlignment(.trailing)
									.frame(maxWidth: .infinity, alignment: .trailing)
							}
							Text(verse.translationEn)
								.foregroundStyle(Color.neutral)
								.font(.default)
								.multilineTextAlignment(.leading)
								.frame(maxWidth: .infinity, alignment: .leading)
						}
						.id(verse.number)
						.padding(.vertical, 8)
						.padding(.horizontal, 16)
						.overlay(
							RoundedRectangle(cornerRadius: 12)
								.stroke(Color.neutral, lineWidth: 1))

					}
				}
				.navigationTitle(surah.name)
				.navigationBarTitleDisplayMode(.inline)
				.toolbar(.hidden, for: .tabBar)
				.scrollTargetLayout()
			}
			.padding(12)
			.scrollPosition(id: $scrollPosition)
		}
		.task {
			surahAyah = quranHelper.loadSurahAyah(surahNumber: surah.id)

			if let ayah = todayVerse?.verse?.number {
				withAnimation {
					scrollPosition = ayah
				}
			}
		}
		.onDisappear {
			
		}
	}

}
