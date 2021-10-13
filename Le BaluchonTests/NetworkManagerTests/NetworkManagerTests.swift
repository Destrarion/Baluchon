//
//  NetworkManagerTests.swift
//  Le BaluchonTests
//
//  Created by Fabien Dietrich on 08/01/2021.
//  Copyright © 2021 Fabien Dietrich. All rights reserved.
//

@testable import Le_Baluchon
import XCTest



class CodableFake: Codable { }

class NetworkManagerTests: XCTestCase {
    
    // MARK: - Test - Fetch
    
    func testFetchGivenNoErrorAndNoResponseWhenFetchThenGetInvalidCodeError() {
        //let urlSessionFake = URLSessionFake(data: nil, response: nil, error: nil)
        
        MockURLProtocol.requestHandler = { request in
            let response = FakeResponseData.responseKO
            return (response, nil)
        }

        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let networkManager = NetworkManager(sessionConfiguration: configuration)
        
        
        let expectation = expectation(description: "Wait for callback...")
        
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<CodableFake, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .responseCodeIsInvalid)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    func testFetchGivenErrorNetworkWhenFetchThenGetUnknownError() {
        
        MockURLProtocol.requestHandler = { request in
            throw MockError.test
        }

        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let networkManager = NetworkManager(sessionConfiguration: configuration)
        
        
        let expectation = expectation(description: "Wait for callback...")
        
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<CodableFake, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .unknownError)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    
    func testFetchGivenWrongFormatDatakWhenFetchThenGetDecoddedDataError() {
        //let urlSessionFake = URLSessionFake(data: nil, response: nil, error: nil)
        
        let wrongFormatData = """
    {
      "base": "EUR",
      "date": 10,
      "rates": {
        "CAD": 1.565,
        "CHF": 1.1798,
        "GBP": 0.87295,
        "SEK": 10.2983,
        "EUR": 1.092,
        "USD": 1.2234
      }
    }
    """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = FakeResponseData.responseOK
            return (response, wrongFormatData)
        }

        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let networkManager = NetworkManager(sessionConfiguration: configuration)
        
        
        let expectation = expectation(description: "Wait for callback...")
        
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<ExchangeResponse, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .failedToDecodeJsonToCodableStruct)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }

    
    
    func testFetchGivenValidFormatDatakWhenFetchThenGetSuccessDecodedData() {
        //let urlSessionFake = URLSessionFake(data: nil, response: nil, error: nil)
        
        let validFormatData = """
    {
        "success": true,
        "timestamp": 1593491765,
        "base": "EUR",
        "date": "2020-06-30",
        "rates": {
            "AED": 4.12997,
            "AFN": 87.084667
        }
    }
    """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = FakeResponseData.responseOK
            return (response, validFormatData)
        }

        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let networkManager = NetworkManager(sessionConfiguration: configuration)
        
        
        let expectation = expectation(description: "Wait for callback...")
        
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<ExchangeResponse, NetworkManagerError>) in
            switch result {
            case .success(let decoddedResponse):
                XCTAssertTrue(decoddedResponse.success)
            case .failure:
                XCTFail()
                
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - Test - FetchData
    
    
    
    func testFetchDataGivenNoErrorAndNoResponseWhenFetchThenGetInvalidCodeError() {
        //let urlSessionFake = URLSessionFake(data: nil, response: nil, error: nil)
        
        MockURLProtocol.requestHandler = { request in
            let response = FakeResponseData.responseKO
            return (response, nil)
        }

        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let networkManager = NetworkManager(sessionConfiguration: configuration)
        
        
        let expectation = expectation(description: "Wait for callback...")
        
        
        networkManager.fetchData(url: URL(string: "www.test.com")!) { (result: Result<Data, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .responseCodeIsInvalid)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    func testFetchDataGivenErrorNetworkWhenFetchThenGetUnknownError() {
        
        MockURLProtocol.requestHandler = { request in
            throw MockError.test
        }

        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let networkManager = NetworkManager(sessionConfiguration: configuration)
        
        
        let expectation = expectation(description: "Wait for callback...")
        
        
        networkManager.fetchData(url: URL(string: "www.test.com")!) { (result: Result<Data, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .unknownError)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    
    func testFetchDataGivenValidFormatDatakWhenFetchThenGetSuccessData() {
        //let urlSessionFake = URLSessionFake(data: nil, response: nil, error: nil)
        
        let validFormatData = "data".data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = FakeResponseData.responseOK
            return (response, validFormatData)
        }

        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let networkManager = NetworkManager(sessionConfiguration: configuration)
        
        
        let expectation = expectation(description: "Wait for callback...")
        
        
        networkManager.fetchData(url: URL(string: "www.test.com")!) { (result: Result<Data, NetworkManagerError>) in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTFail()
                
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    
    
}

