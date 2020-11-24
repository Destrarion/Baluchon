import Foundation



enum Currency {
    case usDollar, euro, swissFrancs
    
    var currencyCode: String {
        switch self {
        case .euro: return "EUR"
        case .swissFrancs: return "CHF"
        case .usDollar: return "USD"
        }
    }
    
    var symbol: String {
        switch self {
        case .euro: return "€"
        case .swissFrancs: return "CHF"
        case .usDollar: return "$"
        }
    }
    
}
