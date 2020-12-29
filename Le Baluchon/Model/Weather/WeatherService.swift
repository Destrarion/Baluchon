import Foundation

class WeatherService {
    
    init(
        networkManager: NetworkManager = NetworkManager(),
        weatherUrlProvider: WeatherUrlProvider = WeatherUrlProvider()
    ) {
        self.networkManager = networkManager
        self.weatherUrlProvider = weatherUrlProvider
    }
    
    private let networkManager : NetworkManager
    private let weatherUrlProvider : WeatherUrlProvider
    
    //MARK:- GET Temperature
    // Request Creation
    func getWeather (town: String , callback: @escaping (Result<WeatherResponse, NetworkManagerError>) -> Void) {
        guard let requestURL = weatherUrlProvider.createWeatherRequestUrl(
            town: town
        )else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        networkManager.fetch(url: requestURL, callback: callback)
    }
    
    //MARK:- Get Image
    
    func getWeatherImageData(imageCode: String, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        guard let requestURL = weatherUrlProvider.createWeatherImageCodeRequestUrl(
            imageCode: imageCode
        )else {
            callback(.failure(.couldNotCreateURL))
            return
        }
        print(requestURL)
        networkManager.fetchData(url: requestURL, callback: callback)
    }
}
