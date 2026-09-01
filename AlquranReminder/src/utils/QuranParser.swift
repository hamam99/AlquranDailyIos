import Foundation

struct QuranParser {
    static func parseSurah(from fileURL: URL) throws -> [Surah] {
        let data = try Data(contentsOf: fileURL)
        return try parseSurah(data: data)
    }

    static func parseSurah(data: Data) throws -> [Surah] {
        return try JSONDecoder().decode([Surah].self, from: data)
    }

    static func parseSurahAyah(from fileURL: URL) throws -> SurahAyahModel {
        let data = try Data(contentsOf: fileURL)
        return try parseSurahAyah(data: data)
    }

    static func parseSurahAyah(data: Data) throws -> SurahAyahModel {
        return try JSONDecoder().decode(SurahAyahModel.self, from: data)
    }
}

// MARK: - Errors

enum QuranParserError: LocalizedError {
    case fileNotFound(String)
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound(let filename):
            return "Quran file not found: \(filename)"
        case .decodingFailed(let error):
            return "Failed to decode Quran JSON: \(error.localizedDescription)"
        }
    }
}
