import Foundation



enum Currency {
    case usDollar, euro
    
    var currencyCode: String {
        switch self {
        case .euro: return "EUR"
        case .usDollar: return "USD"
        }
    }
    
    var symbol: String {
        switch self {
        case .euro: return "€"
        case .usDollar: return "$"
        }
    }
    
}
