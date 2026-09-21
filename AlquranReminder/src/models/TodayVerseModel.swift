import Foundation

struct TodayVerseModel: Codable, Hashable {
    let surahName: String?
    let surahNumber: Int?
    let verse: Verse?
}
