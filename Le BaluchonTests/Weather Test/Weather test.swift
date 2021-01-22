import XCTest
@testable import Le_Baluchon

class weatherAPITest: XCTestCase {
    
    func testGivenBadUrlWhenGetWeatherThenCouldNotCreateUrlError() {
        let failUrlProvider = WeatherUrlProviderAlwaysFailMock()
        let weatherService = WeatherService(weatherUrlProvider: failUrlProvider)
        
        weatherService.getWeather(town: "XXX") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .couldNotCreateURL)
            case .success:
                XCTFail()
            }
        }
    }
    
    func testGivenGoodUrlWhenGetWeatherImageDataThenSucceed(){
        let urlProvider = WeatherUrlProvider()
        let networkManagerMock = NetworkManagerWeatherSuccessMock()
        let weatherService = WeatherService(
            networkManager: networkManagerMock,
            weatherUrlProvider: urlProvider
        )
        
        weatherService.getWeatherImageData(imageCode: "111") { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let result):
                XCTAssertNotNil(result)
            }
        }
    }
    
    func testGivenBadUrlWhenGetWeatherImageDataThenCouldNotCreateUrlError(){
        let failUrlProvider = WeatherUrlProviderAlwaysFailMock()
        let weatherService = WeatherService(
            weatherUrlProvider: failUrlProvider
        )
        
        weatherService.getWeatherImageData(imageCode: "111") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .couldNotCreateURL)
            case .success:
                XCTFail()            }
        }
    }
    
    
    
    
}
