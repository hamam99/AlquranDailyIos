import Foundation

struct QuranHelper {

    func loadAllSurah() -> [Surah] {
        do {
            // Try loading from bundle root first (most common after build)
            guard let fileURL = Bundle.main.url(forResource: "quran", withExtension: "json") else {
                throw QuranParserError.fileNotFound("quran.json not found in bundle")
            }
            let listSurah = try QuranParser.parseSurah(from: fileURL)
            return listSurah
        } catch {
            print("loadAllSurah error : \(error)")

            return []
        }
    }

    func loadSurahAyah(surahNumber: Int?) -> SurahAyahModel? {
        do {
            guard surahNumber != nil else {
                throw QuranParserError.fileNotFound("Surah number is nil")
            }

            guard
                let fileURL = Bundle.main.url(forResource: "\(surahNumber!)", withExtension: "json")
            else {
                throw QuranParserError.fileNotFound("\(surahNumber!).json not found in bundle")
            }

            let surahAyah = try QuranParser.parseSurahAyah(from: fileURL)
            return surahAyah
        } catch {
            print("loadSurahAyah error : \(error)")

            return nil
        }
    }
}
