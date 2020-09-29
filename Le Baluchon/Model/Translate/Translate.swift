//
//  Main.swift
//  API Google Translate
//
//  Created by Fabien Dietrich on 06/07/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import Foundation

public var textToShow: String = ""
// ce que on récupère de l'API
struct TranslateResponse : Decodable {
    let translatedText : String
}
class Translate {
    
    static var shared = Translate()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var translateSession = URLSession(configuration: .default)
    
    init(translateSession: URLSession){
        self.translateSession = translateSession
    }
    

    // Creation de la requete
    func getTranslation(callback : @escaping (Bool, TranslateResponse?) -> Void ){
        let request = Translate.createTranslateRequest()
        
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }

                guard (try? JSONDecoder().decode(TranslateResponse.self, from: data)) != nil
                    else{
                        callback(false,nil)
                        return
                }
                print("data : \(String(describing: data))")
                print("response \(String(describing: response))")
                print("error : \(String(describing: error))")
                              
                // réponse de l'API
                guard let responseJSON = try? JSONDecoder().decode(TranslateResponse.self, from: data) else{
                    callback(false,nil)
                    print("error")
                    return
                }
                              
                textToShow = responseJSON.translatedText
                print(responseJSON.translatedText)
                let translateResponse = TranslateResponse(translatedText: responseJSON.translatedText)
                callback(true,translateResponse)
                print(translateResponse)
                sendNotification(name: "updatePickerView")
                              
                print("data : \(String(describing: data))")
                print("response \(String(describing: response))")
                print("error : \(String(describing: error))")
                print(data)
            }
        }
    task?.resume()
    }
    
    private static func createTranslateRequest() -> URLRequest {
        var request = URLRequest(url: translateURL!)
        request.httpMethod = "Post"
        
        let body = "method=getTranslation&format=json&lang=en"
        request.httpBody = body.data(using: .utf8)

        return request
    }
}



