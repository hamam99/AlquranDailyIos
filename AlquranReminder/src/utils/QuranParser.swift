import Foundation

struct QuranParser {
    /// Parse Quran JSON from Data
    static func parse(data: Data) throws -> [Surah] {
        return try JSONDecoder().decode(Quran.self, from: data)
    }

    /// Parse Quran JSON from a file URL
    static func parse(from fileURL: URL) throws -> [Surah] {
        let data = try Data(contentsOf: fileURL)
        return try parse(data: data)
    }

    /// Parse Quran JSON from a file name in the app bundle
    static func parse(filename: String) throws -> [Surah] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw QuranParserError.fileNotFound(filename)
        }
        return try parse(from: url)
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
