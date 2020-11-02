import Foundation

// MARK: - TranslateResponse
struct TranslateResponse: Codable {
    let data: TranslateDataClass
}

// MARK: - DataClass
struct TranslateDataClass: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
}
