//
//  APIkey.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 18/08/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import Foundation

class UrlCreation {
    
     func createExchangeRateRequestUrl() -> URL? {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            .init(name: "access_key", value: "bf34b73ea045d5497e74fe133b2846a2")
        ]
    
        
        return urlComponents.url
    }
    
    func createTranslateRequestUrl(textToTranslate: String, targetLanguage: String, sourceLanguage: String) -> URL? {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            .init(name: "key", value: "AIzaSyCJb-64s8cpsAcdwa03C4fx-iJ3ZfwuXxU"),
            .init(name: "q", value: textToTranslate),
            .init(name: "target", value: targetLanguage),
            .init(name: "source", value: sourceLanguage)
        ]
        
        return urlComponents.url
    }
    
    func createWeatherRequestUrl () -> URL? {
        var urlComponents = URLComponents()
        
        urlComponents.queryItems = [
            .init(name:"key", value: "864fbc812b28e30ad18d55bc00bc96c2"),
        
        ]
        
        return urlComponents.url
    }
}
