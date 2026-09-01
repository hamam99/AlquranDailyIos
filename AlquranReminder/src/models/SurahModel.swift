import Foundation

// MARK: - Quran Models

/// Represents translations of a Surah name in multiple languages
struct SurahNameTranslations: Codable, Hashable {
    let ar: String  // Arabic
    let en: String  // English
    let id: String  // Indonesian

    enum CodingKeys: String, CodingKey {
        case ar, en, id
    }
}

/// Represents a chapter (Surah) of the Quran
struct Surah: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let nameTranslations: SurahNameTranslations
    let numberOfAyah: Int
    let numberOfSurah: Int
    let place: String
    let recitation: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case name
        case nameTranslations = "name_translations"
        case numberOfAyah = "number_of_ayah"
        case numberOfSurah = "number_of_surah"
        case place
        case recitation
        case type
    }

    // Memberwise initializer for programmatic creation
    init(
        name: String,
        nameTranslations: SurahNameTranslations,
        numberOfAyah: Int,
        numberOfSurah: Int,
        place: String,
        recitation: String,
        type: String
    ) {
        self.name = name
        self.nameTranslations = nameTranslations
        self.numberOfAyah = numberOfAyah
        self.numberOfSurah = numberOfSurah
        self.place = place
        self.recitation = recitation
        self.type = type
        self.id = numberOfSurah
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.nameTranslations = try container.decode(
            SurahNameTranslations.self, forKey: .nameTranslations)
        self.numberOfAyah = try container.decode(Int.self, forKey: .numberOfAyah)
        self.numberOfSurah = try container.decode(Int.self, forKey: .numberOfSurah)
        self.place = try container.decode(String.self, forKey: .place)
        self.recitation = try container.decode(String.self, forKey: .recitation)
        self.type = try container.decode(String.self, forKey: .type)

        // Use numberOfSurah as the id
        self.id = self.numberOfSurah
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(nameTranslations, forKey: .nameTranslations)
        try container.encode(numberOfAyah, forKey: .numberOfAyah)
        try container.encode(numberOfSurah, forKey: .numberOfSurah)
        try container.encode(place, forKey: .place)
        try container.encode(recitation, forKey: .recitation)
        try container.encode(type, forKey: .type)
    }
}

// MARK: - Type Aliases

/// Array of all Surahs in the Quran
// typealias Quran = [Surah]


