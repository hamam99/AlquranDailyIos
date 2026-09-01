import SwiftUI

struct SurahDetailView: View {
	var surah: Surah


	var body: some View {
		ZStack {
			VStack {
				Text(surah.name)
					.font(.largeTitle)
					.padding()
			}
			.navigationTitle(surah.name)
			.navigationBarTitleDisplayMode(.inline)
			.toolbar(.hidden, for: .tabBar)
		}.task {
		}
	}
}
