//
//  ExchangeRate.swift
//  taux de change API
//
//  Created by Fabien Dietrich on 23/05/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import Foundation

public var resultLastRequestRate : [String : Double] = [:]

// ce que on récupère de l'API
struct FixerResponse: Decodable {
    let rates: [String: Double]
    let date: String
}



class ExchangeRate {
    
    var symbolSelected : String = "Select a Symbol"
    
// all thing under this commentary contain the AOI Request
    static var shared = ExchangeRate()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var exchangeRateSession = URLSession(configuration: .default)
    
    init(exchangeRateSession: URLSession){
        self.exchangeRateSession = exchangeRateSession
    }
    
    private static let exchangeUrl = URL(string: "")!
    
    // Creation de la requete
    func getExchangeRate(callback : @escaping (Bool, FixerResponse?) -> Void) {
        let request = ExchangeRate.createExchangeRateRequest()
        
       task?.cancel()
        task = exchangeRateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard (try? JSONDecoder().decode(FixerResponse.self, from: data)) != nil
                    else{
                        callback(false,nil)
                        return
                }
                
            print("data : \(String(describing: data))")
            print("response \(String(describing: response))")
            print("error : \(String(describing: error))")
                
            // réponse de l'API
                guard let responseJSON = try? JSONDecoder().decode(FixerResponse.self, from: data) else{
                    callback(false,nil)
                    print("error")
                    return
                }
                
                resultLastRequestRate = responseJSON.rates
                print(responseJSON.date)
                let fixerResponse = FixerResponse(rates: responseJSON.rates, date: responseJSON.date)
                callback(true,fixerResponse)
                print(fixerResponse)
                
                print("data : \(String(describing: data))")
                print("response \(String(describing: response))")
                print("error : \(String(describing: error))")
                print(data)
            }
        }
        task?.resume()
    }
   private static func createExchangeRateRequest() -> URLRequest {
          var request = URLRequest(url: exchangeUrl)
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
