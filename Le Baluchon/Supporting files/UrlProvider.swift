import Foundation





//MARK:- EXCHANGE RATE

protocol CurrencyUrlProviderProtocol {
    func createExchangeRateRequestUrl() -> URL?
}

class CurrencyUrlProvider: CurrencyUrlProviderProtocol {

    
    func createExchangeRateRequestUrl() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            .init(name: "access_key", value: "bf34b73ea045d5497e74fe133b2846a2")
        ]
        
        return urlComponents.url
    }
    
}

//MARK:- TRANSLATE

protocol TranslateUrlProviderProtocol {
    func createTranslateRequestUrl(textToTranslate: String, targetLanguage: String, sourceLanguage: String) -> URL?
}

class TranslateUrlProvider: TranslateUrlProviderProtocol {
    
    
    func createTranslateRequestUrl(textToTranslate: String, targetLanguage: String, sourceLanguage: String) -> URL? {
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




// MARK:- WEATHER

protocol WeatherUrlProviderProtocol {
    func createWeatherRequestUrl(town: String) -> URL?
    
    func createWeatherImageCodeRequestUrl(imageCode: String) -> URL?
}

class WeatherUrlProvider: WeatherUrlProviderProtocol {

    
    func createWeatherRequestUrl(town: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            .init(name: "q", value: town),
            .init(name: "appid", value: "864fbc812b28e30ad18d55bc00bc96c2"),
            .init(name: "units", value: "metric")
        ]
        return urlComponents.url
    }
    
    
    
    
    func createWeatherImageCodeRequestUrl(imageCode: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "openweathermap.org"
        urlComponents.path = "/img/wn/\(imageCode)@2x.png"
        
        return urlComponents.url
    }
}

