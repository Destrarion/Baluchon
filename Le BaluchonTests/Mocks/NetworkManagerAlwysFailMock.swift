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
