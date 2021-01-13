//
//  taux_de_change_APITests.swift
//  taux de change APITests
//
//  Created by Fabien Dietrich on 23/05/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class taux_de_change_APITests: XCTestCase {
    
    
    
    func testGivenBadUrlWhenGetRateThenGetCouldNotCreateUrlError() {
        let failUrlProvider = CurrencyUrlProviderAlwazsFailMock()
        let exchangeRateService = ExchangeRateService(currencyUrlProvider: failUrlProvider)
        
        
        exchangeRateService.getRate { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .couldNotCreateURL)
            case .success:
                XCTFail()
            }
        }
    }
    
    
    func testGivenBadWhenGetRateThenGetCouldNotCreateUrlError() {
        let networkManagerRateSuccessMock = NetworkManagerRateSuccessMock()
        let exchangeRateService = ExchangeRateService(networkManager: networkManagerRateSuccessMock)
        
        
        exchangeRateService.getRate { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success:
               XCTAssert(true)
            }
        }
    }
    


//    func testGetExchangeRateShouldPostFailedCallbackifError() {
//        //Given
//        let exchangeRate = ExchangeRate(
//            exchangeRateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        exchangeRate.getExchangeRate { ( success, fixerResponse ) in
//            //Then
//            XCTAssertFalse(success)
//            XCTAssertNil(fixerResponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetExchangeRateShouldPostFailedCallbackNoData() {
//        //Given
//        let exchangeRate = ExchangeRate(
//            exchangeRateSession: URLSessionFake(data: nil, response: nil, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        exchangeRate.getExchangeRate { ( success, fixerResponse ) in
//            //Then
//            XCTAssertFalse(success)
//            XCTAssertNil(fixerResponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetExchangeRateShouldPostFailedIfIncorrectResponse() {
//        //Given
//        let exchangeRate = ExchangeRate(
//            exchangeRateSession: URLSessionFake(data: FakeResponseData.rateCorrectData, response: FakeResponseData.responseKO, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        exchangeRate.getExchangeRate { ( success, fixerResponse ) in
//            //Then
//            XCTAssertFalse(success)
//            XCTAssertNil(fixerResponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetExchangeRateShouldPostFailedCallbackIfIncorrectData() {
//        //Given
//        let exchangeRate = ExchangeRate(
//            exchangeRateSession: URLSessionFake(data: FakeResponseData.rateIncorrectData, response: FakeResponseData.responseOK, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        exchangeRate.getExchangeRate { ( success, fixerResponse ) in
//            //Then
//            XCTAssertFalse(success)
//            XCTAssertNil(fixerResponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//    func testGetExchangeRateShouldPostFailedCallbackIfNoErroreAndCorrectData() {
//        //Given
//        let exchangeRate = ExchangeRate(
//            exchangeRateSession: URLSessionFake(data: FakeResponseData.rateCorrectData, response: FakeResponseData.responseKO, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        exchangeRate.getExchangeRate { ( success, fixerResponse ) in
//            //Then
//            XCTAssertFalse(success)
//            XCTAssertNil(fixerResponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGivenEmptyValueNumber_WhenCalculExchangeRate_ThenReturn(){
//        //Given
//        let exchangeRate = ExchangeRate(
//            exchangeRateSession: URLSessionFake(data: FakeResponseData.rateCorrectData, response: FakeResponseData.responseOK, error: nil))
//
//        exchangeRate.getExchangeRate{ (success , fixerResponse) in
//            if success, let _ = fixerResponse{
//                exchangeRate.calculExchangeRateWithValue("USD", "")
//                XCTAssertTrue(exchangeRate.resultCalculationRate == 0)
//                
//            }
//        }
//    }
//
//    func testGivenAValueNumber_WhenCalculExchangeRate_ThenReturn(){
//        //Given
//        let exchangeRate = ExchangeRate(
//            exchangeRateSession: URLSessionFake(data: FakeResponseData.rateCorrectData, response: FakeResponseData.responseOK, error: nil))
//
//        exchangeRate.getExchangeRate{ (success , fixerResponse) in
//            if success, let _ = fixerResponse{
//                exchangeRate.calculExchangeRateWithValue("USD", "1")
//                XCTAssertTrue(exchangeRate.resultCalculationRate == 1.124352)
//
//            }
//        }
//    }
}
