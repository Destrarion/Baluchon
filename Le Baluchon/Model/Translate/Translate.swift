import Foundation

class Translate {
    
    static var shared = Translate()
    private init() {}
    
    private let networkManager = NetworkManager()
    private let urlCreation = UrlCreation()
    
    // Creation de la requete
    func getTranslation(textToTranslate: String, targetLanguage: String, sourceLanguage: String, callback: @escaping (Result<TranslateResponse, NetworkManagerError>) -> Void) {
        guard let requestURL = urlCreation.createTranslateRequestUrl(
            textToTranslate: textToTranslate,
            targetLanguage: targetLanguage,
            sourceLanguage: sourceLanguage
        ) else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        
        networkManager.fetch(url: requestURL, callback: callback)
    }

}


