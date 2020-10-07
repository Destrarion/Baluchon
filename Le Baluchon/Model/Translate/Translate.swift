//
//  Main.swift
//  API Google Translate
//
//  Created by Fabien Dietrich on 06/07/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import Foundation


// ce que on récupère de l'API
struct TranslateResponse : Decodable {
    let translatedText : String
}

var languageSelectedFrom = "&target="
var textToTranslate = "&q="
var resultTranslate = ""
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
                              
                textToTranslate = responseJSON.translatedText
                print(responseJSON.translatedText)
                let translateResponse = TranslateResponse(translatedText: responseJSON.translatedText)
                callback(true,translateResponse)
                print(translateResponse)
                resultTranslate = "\(translateResponse)"
                              
                print("data : \(String(describing: data))")
                print("response \(String(describing: response))")
                print("error : \(String(describing: error))")
                print(data)
            }
        }
    task?.resume()
    }
    
    private static func createTranslateRequest() -> URLRequest {
        var requestURLString =  "\(translateURLString)" + "\(languageSelectedFrom)" + "\(textToTranslate)"
        let requestURL = URL(string: requestURLString)
        var request = URLRequest(url: requestURL! )
        request.httpMethod = "GET"
        
        let body = "method=getTranslation&format=json&lang=en"
        request.httpBody = body.data(using: .utf8)

        return request
    }
}



