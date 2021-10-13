import Foundation

class WeatherService {
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        weatherUrlProvider: WeatherUrlProviderProtocol = WeatherUrlProvider()
    ) {
        self.networkManager = networkManager
        self.weatherUrlProvider = weatherUrlProvider
    }
    
    private let networkManager : NetworkManagerProtocol
    private let weatherUrlProvider : WeatherUrlProviderProtocol
    
    //MARK:- GET Temperature
    /// Request Weather text API
    func getWeather(town: String , callback: @escaping (Result<WeatherResponse, NetworkManagerError>) -> Void) {
        guard let requestURL = weatherUrlProvider.createWeatherRequestUrl(
            town: town
        )else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        networkManager.fetch(url: requestURL, callback: callback)
    }
    
    //MARK:- Get Image
    /// Request Weather Image API
    func getWeatherImageData(imageCode: String, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        guard let requestURL = weatherUrlProvider.createWeatherImageCodeRequestUrl(
            imageCode: imageCode
        )else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        networkManager.fetchData(url: requestURL, callback: callback)
    }
}
