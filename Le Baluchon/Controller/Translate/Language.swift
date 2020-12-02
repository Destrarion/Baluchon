enum Language {
    case english, french
    
    var languageCode: String {
        switch self {
        case .english: return "EN"
        case .french: return "FR"
        }
    }
    
    var name: String {
        switch self {
        case .english: return "English"
        case .french: return "French"
        }
    }
}

