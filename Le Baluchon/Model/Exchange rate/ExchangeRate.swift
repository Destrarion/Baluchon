import Foundation

class ExchangeRate {
    private let networkManager = NetworkManager()
    private let urlCreation = UrlCreation()
    
    var resultCalculationRate : Double = 0
    
    private var task: URLSessionDataTask?
    private let exchangeRateSession: URLSession
    
    init(exchangeRateSession: URLSession = URLSession(configuration: .default)) {
        self.exchangeRateSession = exchangeRateSession
    }
    
    // Here is the function that should replace getExchangeRate, inspired by getTranslation
    func getRate(callback : @escaping (Result<ExchangeResponse, NetworkManagerError>)-> Void) {
        guard let requestURL = urlCreation.createExchangeRateRequestUrl() else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        print(requestURL)
        networkManager.fetch(url: requestURL, callback: callback)
    }
    
    private func createExchangeRateRequest() -> URLRequest? {
        
        guard let exchangeURL = urlCreation.createExchangeRateRequestUrl() else { return nil }
        var request = URLRequest(url: exchangeURL)
        request.httpMethod = "POST"
        
        let body = "method=getExchangeRate&format=json&lang=en"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
}

/// Method created to simplify sending a notification
func sendNotification(name: String) {
    let name = Notification.Name(rawValue: name)
    let notification = Notification(name: name)
    NotificationCenter.default.post(notification)
}
