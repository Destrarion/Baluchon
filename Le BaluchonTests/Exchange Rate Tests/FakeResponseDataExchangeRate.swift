//
//  FakeResponseData.swift
//  taux de change APITests
//
//  Created by Fabien Dietrich on 30/06/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var rateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Rate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let rateIncorrectData = "erreur".data(using: .utf8)!
    

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!


    // MARK: - Error
    class RateError: Error {}
    static let error = RateError()
}
