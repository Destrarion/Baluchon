//
//  ExchangeRate.swift
//  taux de change API
//
//  Created by Fabien Dietrich on 23/05/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import Foundation

//public var resultLastRequestRate : [String : Double] = [:]




class ExchangeRate {
    private let networkManager = NetworkManager()
    private let urlCreation = UrlCreation()
    
    var resultCalculationRate : Double = 0
    
    // all thing under this commentary contain the API Request
    static var shared = ExchangeRate()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var exchangeRateSession = URLSession(configuration: .default)
    
    init(exchangeRateSession: URLSession){
        self.exchangeRateSession = exchangeRateSession
    }
    
    // Here is the function that should replace getExchangeRate, inspired by getTranslation
    func getRate(callback : @escaping (Result<ExchangeResponse, NetworkManagerError>)-> Void) {
        guard let requestURL = urlCreation.createExchangeRateRequestUrl()
            else{
                callback(.failure(.couldNotCreateURL))
                return
        }
        print(requestURL)
        networkManager.fetch(url: requestURL, callback: callback)
    }
    
    private func createExchangeRateRequest() -> URLRequest {
        let exchangeURL = urlCreation.createExchangeRateRequestUrl()
        var request = URLRequest(url: exchangeURL!)
        request.httpMethod = "POST"
        
        let body = "method=getExchangeRate&format=json&lang=en"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
}

/// Method created to simplify sending a notification
func sendNotification(name: String) {
    let name = Notification.Name(rawValue: name)
    let notification = Notification(name: name)
    NotificationCenter.default.post(notification)
}
