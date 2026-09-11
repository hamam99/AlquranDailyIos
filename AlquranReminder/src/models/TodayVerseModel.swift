import Foundation

struct TodayVerseModel: Decodable, Hashable {
    let surahName: String?
    let surahNumber: Int?
    let verse: Verse?
}
