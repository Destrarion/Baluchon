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
        guard let request = Translate.createTranslateRequestUrl() else {
            callback(false,nil)
            return
        }
        
        task?.cancel()
        task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
    
    private static func createTranslateRequestUrl() -> URL? {
        var urlConponents = URLComponents()
        
        // http://data.fixer.io/api/latest?access_key=AIzaSyCJb-64s8cpsAcdwa03C4fx-iJ3ZfwuXxU
        
        urlConponents.scheme = "https"
        urlConponents.host = "translation.googleapis.com/language/translate/v2"
        //urlConponents.path = "latest"
        urlConponents.queryItems = [
            .init(name: "key", value: "AIzaSyCJb-64s8cpsAcdwa03C4fx-iJ3ZfwuXxU"),
            .init(name: "q", value: "Francais"), //textToTranslate)
            .init(name: "target", value: "EN"),
            .init(name: "source", value: "FR")
            
        ]
        
        
        
        //let requestURLString =  "\(translateURLString)"+"\(languageSelectedFrom)"+"\(textToTranslate)"
        guard let requestURL = urlConponents.url else {
            return nil
            
        }
        
        /* var request = URLRequest(url: requestURL )
         request.httpMethod = "Post"
         
         let body = "method=getTranslation&format=json&lang=en"
         request.httpBody = body.data(using: .utf8)
         */
        
        
        return requestURL
    }
}



