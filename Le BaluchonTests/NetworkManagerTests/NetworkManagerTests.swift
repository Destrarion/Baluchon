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
        let urlSessionFake = URLSessionFake(data: nil, response: nil, error: nil)
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<CodableFake, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .responseCodeIsInvalid)
            }
        }
    }
    
    func testFetchGivenNoDataWhenFetchThenNoDataError(){
        let urlSessionFake = URLSessionFake(data: nil, response: FakeResponseData.responseOK , error: nil)
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<CodableFake, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }
        }
    }
    
    func testFetchGivenErrorWhenFetchThenUnknownError(){
        let urlSessionFake = URLSessionFake(data: FakeResponseData.rateCorrectData , response: FakeResponseData.responseOK , error: FakeResponseData.error )
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<CodableFake, NetworkManagerError>) in
            switch result {
            case .success :
                XCTFail()
            case.failure(let error):
                XCTAssertEqual(error, .unknownError)
            }
        }
    }
    
    func testFetchGivenIncorrectDataWhenFetchThenFailedToDecodeJsonToCodableStruct(){
        let urlSessionFake = URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK , error: nil)
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<CodableFake, NetworkManagerError>) in
            switch result {
            case .success :
                XCTFail()
            case.failure(let error):
                XCTAssertEqual(error, .failedToDecodeJsonToCodableStruct)
            }
        }
    }
    
    func testFetchGivenDataCorrectResponseOkNoErrorWhenFetchThenSuccessDecoding(){
        let urlSessionFake = URLSessionFake(data: FakeResponseData.rateCorrectData , response: FakeResponseData.responseOK , error: nil )
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetch(url: URL(string: "www.test.com")!) { (result: Result<CodableFake, NetworkManagerError>) in
            switch result {
            case .success (let response):
                XCTAssertNotNil(response)
            case.failure:
                XCTFail()
            }
        }
    }
    
    // MARK: - Test - FetchData
    func testFetchDataGivenDataCorrectResponseOkNoErrorWhenFetchDataThenSuccessDecoding(){
        let urlSessionFake = URLSessionFake(data: FakeResponseData.rateCorrectData , response: FakeResponseData.responseOK , error: nil )
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetchData(url: URL(string: "www.test.com")!) { (result: Result<Data, NetworkManagerError>) in
            switch result {
            case .success (let response):
                XCTAssertNotNil(response)
            case .failure:
                XCTFail()
            }
        }
    }
    
    
    func testFetchDataGivenNoErrorAndNoResponseWhenFetchThenGetInvalidCodeError() {
        let urlSessionFake = URLSessionFake(data: nil, response: nil, error: nil)
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        
        networkManager.fetchData(url: URL(string: "www.test.com")!) { (result: Result<Data, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .responseCodeIsInvalid)
            }
        }
    }
    
    func testFetchDataGivenNoDataWhenFetchThenNoDataError(){
        let urlSessionFake = URLSessionFake(data: nil, response: FakeResponseData.responseOK , error: nil)
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetchData(url: URL(string: "www.test.com")!) { (result: Result<Data, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            }
        }
    }
    
    func testFetchDataGivenCorrectDataResponseOkNoErrorWhenFetchDateThenSuccess(){
        let urlSessionFake = URLSessionFake(data: FakeResponseData.rateCorrectData, response: FakeResponseData.responseOK, error: nil)
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetchData(url: URL(string: "www.test.com")!) { (result: Result<Data,NetworkManagerError>) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                
            case .failure:
                XCTFail()
            }
        }
    }
    
    func testFetchDataGivenEroorWhenFetchThenError(){
        let urlSessionFake = URLSessionFake(data: FakeResponseData.rateCorrectData, response: FakeResponseData.responseOK , error: FakeResponseData.error)
        
        let networkManager = NetworkManager(session: urlSessionFake)
        
        networkManager.fetchData(url: URL(string: "www.test.com")!) { (result: Result<Data, NetworkManagerError>) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .unknownError)
            }
        }
    }
}

