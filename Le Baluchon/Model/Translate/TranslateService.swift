
class TranslateService {
    
    init(
        networkManager: NetworkManager = NetworkManager(),
        translateUrlProvider: TranslateUrlProvider = TranslateUrlProvider()
    ) {
        self.networkManager = networkManager
        self.translateUrlProvider = translateUrlProvider
    }
    
    
    
    private let networkManager: NetworkManager
    private let translateUrlProvider: TranslateUrlProvider
    
    // Creation de la requete
    func getTranslation(textToTranslate: String, targetLanguage: String, sourceLanguage: String, callback: @escaping (Result<TranslateResponse, NetworkManagerError>) -> Void) {
        guard let requestURL = translateUrlProvider.createTranslateRequestUrl(
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


