//
//  NetworkManagerAlwysFailMock.swift
//  Le BaluchonTests
//
//  Created by Fabien Dietrich on 13/01/2021.
//  Copyright © 2021 Fabien Dietrich. All rights reserved.
//

@testable import Le_Baluchon
import Foundation


class NetworkManagerAlwysFailMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, callback: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        callback(.failure(.noData))
    }
    
    func fetchData(url: URL, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        callback(.failure(.noData))
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
    func fetch<T>(url: URL, callback: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        let weatherResponse = WeatherResponse(
            coord: Coord(lon: 1, lat: 1),
            weather: [],
            base: "",
            main: Main(
                temp: 1,
                feelsLike: 1,
                tempMin: 1,
                tempMax: 1,
                pressure: 1,
                humidity: 1
            ),
            visibility: 1,
            wind: Wind(speed: 1, deg: 1),
            clouds: Clouds(all: 1),
            dt: 1,
            sys: Sys(
                type: 1,
                id: 1,
                country: "",
                sunrise: 1,
                sunset: 1
            ),
            timezone: 1,
            id: 1,
            name: "",
            cod: 1
        )
        callback(.success(weatherResponse as! T))
    }
    
    func fetchData(url: URL, callback: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        callback(.success(Data()))
    }
    
}
