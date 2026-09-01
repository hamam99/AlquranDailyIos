import Foundation

// MARK: - SurahAyahModel
struct SurahAyahModel: Decodable, Hashable {
    let name: String
    let nameTranslations: NameTranslations
    let numberOfAyah, numberOfSurah: Int
    let place: String
    let recitations: [Recitation]
    let type: String
    let verses: [Verse]
    let tafsir: Tafsir

    enum CodingKeys: String, CodingKey {
        case name
        case nameTranslations = "name_translations"
        case numberOfAyah = "number_of_ayah"
        case numberOfSurah = "number_of_surah"
        case place
        case recitations
        case type
        case verses
        case tafsir
    }
}

// MARK: - NameTranslations
struct NameTranslations: Decodable, Hashable {
    let ar, en, id: String
}

// MARK: - Recitation
struct Recitation: Decodable, Hashable {
    let name: String
    let audioURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case audioURL = "audio_url"
    }
}

// MARK: - Tafsir
struct Tafsir: Decodable, Hashable {
    let id: ID
}

// MARK: - ID
struct ID: Decodable, Hashable {
    let kemenag: Kemenag
}

// MARK: - Kemenag
struct Kemenag: Decodable, Hashable {
    let name, source: String
    let text: [String: String]
}

// MARK: - Verse
struct Verse: Decodable, Hashable {
    let number: Int
    let text: String
    let translationEn: String
    let translationID: String

    enum CodingKeys: String, CodingKey {
        case number
        case text
        case translationEn = "translation_en"
        case translationID = "translation_id"
    }
}
