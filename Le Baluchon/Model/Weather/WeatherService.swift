//
//  WeatherService.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 06/12/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

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
    
    // [°C] = ([°F] - 32) x 5/9
    //[°F] = [°C] x 9/5 + 32
    private func celsiusConvertionToFahrenheit(celsius: Int ) -> Int{
        let fahrenheit : Int = celsius * 9/5 + 32
        return fahrenheit
    }
    private func fahrenheitToCelsius(fahrenheit: Int) -> Int{
        let celsius = (fahrenheit - 32) * 5/9
        return celsius
    }
    
    
}
