import Foundation

class Translate {
    
    static var shared = Translate()
    private init() {}
    
    private let networkManager = NetworkManager()
    
    
    // Creation de la requete
    func getTranslation(textToTranslate: String, targetLanguage: String, sourceLanguage: String, callback: @escaping (Result<TranslateResponse, NetworkManagerError>) -> Void) {
        guard let requestURL = createTranslateRequestUrl(
            textToTranslate: textToTranslate,
            targetLanguage: targetLanguage,
            sourceLanguage: sourceLanguage
        ) else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        
        networkManager.fetch(url: requestURL, callback: callback)
    }
    
    private func createTranslateRequestUrl(textToTranslate: String, targetLanguage: String, sourceLanguage: String) -> URL? {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            .init(name: "key", value: "AIzaSyCJb-64s8cpsAcdwa03C4fx-iJ3ZfwuXxU"),
            .init(name: "q", value: textToTranslate),
            .init(name: "target", value: targetLanguage),
            .init(name: "source", value: sourceLanguage)
        ]
        
        return urlComponents.url
    }
}


