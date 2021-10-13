import Foundation

enum NetworkManagerError: Error {
    case unknownError
    case responseCodeIsInvalid
    case failedToDecodeJsonToCodableStruct
    case couldNotCreateURL
}

extension NetworkManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .couldNotCreateURL: return "couldNotCreateURL"
        case .unknownError: return "unknownError"
        case .failedToDecodeJsonToCodableStruct: return "failedToDecodeJsonToCodableStruct"
        case .responseCodeIsInvalid: return "responseCodeIsInvalid"
        }
    }
}
