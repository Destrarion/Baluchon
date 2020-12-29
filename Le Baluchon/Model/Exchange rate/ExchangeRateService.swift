import Foundation

class ExchangeRateService {
    init(
        networkManager: NetworkManager = NetworkManager(),
        currencyUrlProvider: CurrencyUrlProvider = CurrencyUrlProvider()
    ) {
        self.networkManager = networkManager
        self.currencyUrlProvider = currencyUrlProvider
    }
    

    private let networkManager: NetworkManager
    private let currencyUrlProvider: CurrencyUrlProvider
    
    // Here is the function that should replace getExchangeRate, inspired by getTranslation
    func getRate(callback : @escaping (Result<ExchangeResponse, NetworkManagerError>)-> Void) {
        guard let requestURL = currencyUrlProvider.createExchangeRateRequestUrl() else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        networkManager.fetch(url: requestURL, callback: callback)
    }
    
    var usedRate: Double? {
        guard
            let rates = rates,
            let sourceRate = rates[selectedSourceCurrency.currencyCode],
            let targetRate = rates[selectedTargetCurrency.currencyCode]
            else { return nil  }
       
        return targetRate / sourceRate
    }
    
    var rates: [String: Double]?
    
    var selectedSourceCurrency: Currency = .euro
    var selectedTargetCurrency: Currency = .usDollar
    
    
}
