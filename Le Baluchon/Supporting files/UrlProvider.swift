import Foundation

extension URLComponents: URLComponentsProtocol { }
//MARK:- EXCHANGE RATE
class CurrencyUrlProvider {
    
    init(urlComponents: URLComponentsProtocol = URLComponents()) {
        self.urlComponents = urlComponents
    }
    
    private var urlComponents: URLComponentsProtocol
    
    func createExchangeRateRequestUrl() -> URL? {
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
class TranslateUrlProvider {
    init(urlComponents: URLComponentsProtocol = URLComponents()) {
        self.urlComponents = urlComponents
    }
    
    private var urlComponents: URLComponentsProtocol
    
    func createTranslateRequestUrl(textToTranslate: String, targetLanguage: String, sourceLanguage: String) -> URL? {
        
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
class WeatherUrlProvider {
    
    init(urlComponents: URLComponentsProtocol = URLComponents()) {
        self.urlComponents = urlComponents
    }
    
    
    private var urlComponents: URLComponentsProtocol
    
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
    
    
    
    // http://openweathermap.org/img/wn/10d@2x.png
    
    func createWeatherImageCodeRequestUrl(imageCode: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "openweathermap.org"
        urlComponents.path = "/img/wn/\(imageCode)@2x.png"
        
        return urlComponents.url
    }
}







//MARK:- URL COMPONENTS
protocol URLComponentsProtocol {
    var scheme: String? { get set }
    var host: String? { get set }
    var path: String { get set }
    var queryItems: [URLQueryItem]? { get set }
    var url: URL? { get }
}


class URLComponentsMock: URLComponentsProtocol {
    init(scheme: String? = nil, host: String? = nil, path: String = "", queryItems: [URLQueryItem]? = nil, url: URL? = nil) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
        self.url = url
    }
    
    
    var scheme: String?
    var host: String?
    var path: String
    var queryItems: [URLQueryItem]?
    var url: URL?
}


