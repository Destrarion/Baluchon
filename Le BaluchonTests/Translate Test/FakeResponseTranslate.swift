//
//  FakeResponseTranslate.swift
//  Le BaluchonTests
//
//  Created by Fabien Dietrich on 26/09/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import Foundation

class FakeTranslationResponseData {
    
    static var rateCorrectData : Data? {
        let bundle = Bundle(for: FakeTranslationResponseData.self)
        let url = bundle.url(forResource: "TranslateTest", withExtension: ".json")!
        return try! Data(contentsOf: url)
    }
    
    static let IncorrectData = "error".data(using: .utf8)
    
    
    static let responseOK = HTTPURLResponse(url: URL(string: "")!, statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "")!, statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class RateError: Error {}
    static let error = RateError()
}
