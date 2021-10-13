@testable import Le_Baluchon
import Foundation


class NetworkManagerAlwysFailMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, callback: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        callback(.failure(.unknownError))
    }
    
    func fetchData(url: URL, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        callback(.failure(.unknownError))
    }
    
}



class NetworkManagerRateSuccessMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, callback: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        let exchangeResponse = ExchangeResponse(success: true, timestamp: 4, base: "EUR", date: "010101", rates: ["EUR" :1.5, "USD": 1.2])
        callback(.success(exchangeResponse as! T))
    }
    
    func fetchData(url: URL, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        callback(.success(Data()))
    }
    
}

class NetworkManagerTranslateSuccessMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, callback: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        let translateResponse = TranslateResponse(data: TranslateDataClass(translations: []))
        callback(.success(translateResponse as! T))
    }
    
    func fetchData(url: URL, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        callback(.success(Data()))
    }
    
}

class NetworkManagerWeatherSuccessMock: NetworkManagerProtocol {
    func fetchData(url: URL, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        callback(.success(Data()))
    }
    
    func fetch<T>(url: URL, callback: @escaping (Result <T, NetworkManagerError>) -> Void) where T : Decodable {
        let weatherResponse = WeatherResponse(
            weather: [],
            main: Main(
                temp: 1
            )
        )
        callback(.success(weatherResponse as! T))
    }
}
