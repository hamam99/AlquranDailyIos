import Foundation

struct TodayVerseModel: Decodable, Hashable {
    let surahName: String?
    let surahNumber: String?
    let verse: Verse?
}
