import Foundation

// MARK: - TranslateResponse
struct TranslateResponse: Decodable {
    let data: TranslateDataClass
}

// MARK: - DataClass
struct TranslateDataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Decodable {
    let translatedText: String
}
