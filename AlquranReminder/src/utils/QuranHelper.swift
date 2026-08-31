import Foundation

struct QuranHelper {

    func loadAllSurah() -> [Surah] {

        do {
            // Try loading from bundle root first (most common after build)
            guard let fileURL = Bundle.main.url(forResource: "quran", withExtension: "json") else {
                throw QuranParserError.fileNotFound("quran.json not found in bundle")
            }
            let listSurah = try QuranParser.parse(from: fileURL)
            return listSurah
        } catch {
            print("error : \(error)")

            return []
        }
    }
}
