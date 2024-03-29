import Foundation

class ExchangeRateService {
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        currencyUrlProvider: CurrencyUrlProviderProtocol = CurrencyUrlProvider()
    ) {
        self.networkManager = networkManager
        self.currencyUrlProvider = currencyUrlProvider
    }
    

    private let networkManager: NetworkManagerProtocol
    private let currencyUrlProvider: CurrencyUrlProviderProtocol
    

    func getRate(callback : @escaping (Result<ExchangeResponse, NetworkManagerError>) -> Void) {
        guard let requestURL = currencyUrlProvider.createExchangeRateRequestUrl() else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        networkManager.fetch(url: requestURL, callback: callback)
    }
    
    private var usedRate: Double? {
        guard
            let rates = rates,
            let sourceRate = rates[selectedSourceCurrency.currencyCode],
            let targetRate = rates[selectedTargetCurrency.currencyCode]
            else { return nil  }
       
        let rateAsDecimal = Decimal(targetRate) / Decimal(sourceRate)
        return Double(truncating: rateAsDecimal as NSNumber)
    }
    
    func convertValueWithRate(valueToConvert: Double) -> String {
        guard let usedRate = usedRate else { return "" }
        let convertedValue = valueToConvert * usedRate
        
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.currencySymbol = selectedTargetCurrency.symbol
        
        guard let formattedStringValue = numberFormatter.string(from: convertedValue as NSNumber) else { return ""}
        
        return formattedStringValue
    }
    
    var rates: [String: Double]?
    
    var selectedSourceCurrency: Currency = .euro
    var selectedTargetCurrency: Currency = .usDollar
    
    
}
