
class TranslateService {
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        translateUrlProvider: TranslateUrlProviderProtocol = TranslateUrlProvider()
    ) {
        self.networkManager = networkManager
        self.translateUrlProvider = translateUrlProvider
    }
    
    
    
    private let networkManager: NetworkManagerProtocol
    private let translateUrlProvider: TranslateUrlProviderProtocol
    
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


