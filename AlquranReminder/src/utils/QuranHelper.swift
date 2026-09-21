import Foundation

struct QuranHelper {
    
    func loadAllSurah() -> [Surah] {
        do {
            // Try loading from bundle root first (most common after build)
            guard
                let fileURL = Bundle.main.url(
                    forResource: "quran",
                    withExtension: "json"
                )
                    else {
                throw QuranParserError.fileNotFound(
                    "quran.json not found in bundle"
                )
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
                let fileURL = Bundle.main.url(
                    forResource: "\(surahNumber!)",
                    withExtension: "json"
                )
                    else {
                throw QuranParserError.fileNotFound(
                    "\(surahNumber!).json not found in bundle"
                )
            }
            
            let surahAyah = try QuranParser.parseSurahAyah(from: fileURL)
            return surahAyah
        } catch {
            print("loadSurahAyah error : \(error)")
            
            return nil
        }
    }
    
    func getTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"  // Formats as "20260918"
        
        let todayString = formatter.string(from: Date())
        return todayString
    }
    
    func getTodayVerse() -> TodayVerseModel? {
        let todayVerseAt = UserDefaults.standard.string(
            forKey: "today_verse_at"
        )
        
        let generatedVerse = generateTodayVerse()
        
        if todayVerseAt == getTodayDate() {
            guard
                let todayVerse = UserDefaults.standard.data(
                    forKey: "today_verse"
                )
                    else {
                saveTodayVerse(verse: generatedVerse);
                return generatedVerse
            }
            
            let todayVerseDecoded = try? JSONDecoder().decode(
                TodayVerseModel.self,
                from: todayVerse
            )
            return todayVerseDecoded
        }
        
        saveTodayVerse(verse: generatedVerse);
        return generatedVerse
    }
    
    func saveTodayVerse(verse: TodayVerseModel?) {
        if(verse == nil) {
            return
        }
        let today = getTodayDate()
        UserDefaults.standard.set(today, forKey: "today_verse_at")
        if let encoded = try? JSONEncoder().encode(verse) {
            UserDefaults.standard.set(encoded, forKey: "today_verse")
        }
        
    }
    
    func generateTodayVerse() -> TodayVerseModel? {
        let randomSurahNumber: Int = Int.random(in: 1...114)
        guard let surahDetail = loadSurahAyah(surahNumber: randomSurahNumber),
              let ayah = surahDetail.verses.randomElement()
                else { return nil }
        
        return TodayVerseModel(
            surahName: surahDetail.name,
            surahNumber: surahDetail.numberOfSurah,
            verse: ayah
        )
    }
    
    func getLastReadAyah() -> LastReadModel? {
        guard let data = UserDefaults.standard.data(forKey: "last_read_ayah")
                else {
            return nil
        }
        
        let lastItemRead = try? JSONDecoder().decode(
            LastReadModel.self,
            from: data
        )
        return lastItemRead
        
    }
    
    func saveLastReadAyah(lastRead: LastReadModel) {
        if let encoded = try? JSONEncoder().encode(lastRead) {
            UserDefaults.standard.set(encoded, forKey: "last_read_ayah")
        }
    }
}
