import SwiftUI

struct SurahAyahView: View {
	var surah: Surah
	var quranHelper = QuranHelper()

	@State private var surahAyah: SurahAyahModel? = nil

	var body: some View {
		ZStack {
			ScrollView {
				LazyVStack(spacing: 8) {
					ForEach(surahAyah?.verses ?? [], id: \.number) { verse in
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
			}.padding(12)
		}.task {
			surahAyah = quranHelper.loadSurahAyah(surahNumber: surah.id)
		}
	}
}
