
@testable import Le_Baluchon
import Foundation


class WeatherUrlProviderAlwaysFailMock: WeatherUrlProviderProtocol {
    func createWeatherImageCodeRequestUrl(imageCode: String) -> URL? {
        return nil
    }
    
    func createWeatherRequestUrl(town: String) -> URL? {
        return nil
    }
    
    
}


