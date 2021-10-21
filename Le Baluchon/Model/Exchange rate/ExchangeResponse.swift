import Foundation

// MARK: - CurrencyResponse
struct ExchangeResponse: Decodable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}
