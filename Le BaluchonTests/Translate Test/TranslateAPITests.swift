//
//  TranslateAPITests.swift
//  Le BaluchonTests
//
//  Created by Fabien Dietrich on 28/09/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class TranslateAPITests: XCTestCase {
    
    func testGivenBadUrlWhenGetTranslateThenCouldNotCreateUrlError() {
        let failUrlProvider = TranslateUrlProviderAlwaysFailMock()
        let translateService = TranslateService(translateUrlProvider: failUrlProvider)
        
        translateService.getTranslation(textToTranslate: "world", targetLanguage: "FR", sourceLanguage: "EN") { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .couldNotCreateURL)
            case .success:
                XCTFail()
            }
        }
    }
    
    func testGivenGoodUrlWhenGetWeatherThenSucceed() {
        let urlProvider = TranslateUrlProvider()
        let networkManagerMock = NetworkManagerTranslateSuccessMock()
        let translateService = TranslateService(
            networkManager: networkManagerMock,
            translateUrlProvider: urlProvider
        )

        translateService.getTranslation(textToTranslate: "world", targetLanguage: "FR", sourceLanguage: "EN") { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success:
                XCTAssertNotNil(result)
            }
        }
    }
    
    
//
 //  func testGetTranslationShouldPostFailedCallbackifError(){
 //     let translate = TranslateService(
 //         translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
//
 //     let expectation = XCTestExpectation(description: "Wait for queue change.")
 //     translate.getTranslation { ( success, translateresponse ) in
//
 //         XCTAssertFalse(success)
 //       XCTAssertNil(translateresponse)
 //       expectation.fulfill()
 //    }
 //    wait(for: [expectation], timeout: 0.01)
 //
//}
//
//    func testGetExchangeRateShouldPostFailedCallbackNoData() {
//        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translate.getTranslation{ (success , translateresponse) in
//
//            XCTAssertFalse(success)
//            XCTAssertNil(translateresponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetTranslationShouldPostFailedIfIncorrectResponse() {
//        //Given
//        let translate = TranslateService(
//            translateSession: URLSessionFake(data: FakeResponseData.rateCorrectData, response: FakeResponseData.responseKO, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translate.getTranslation { ( success, fixerResponse ) in
//            //Then
//            XCTAssertFalse(success)
//            XCTAssertNil(fixerResponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetTranslationShouldPostFailedIfIncorrectData() {
//        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.rateIncorrectData, response: FakeResponseData.responseOK, error: nil))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translate.getTranslation{ (success , translate) in
//
//            XCTAssertFalse(success)
//            XCTAssertNil(translate)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
//    func testGetTranslationShouldPostFailedCallbackIfNoErroreAndCorrectData() {
//        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.rateCorrectData, response: FakeResponseData.responseKO, error: nil))
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        translate.getTranslation{ (success , translateresponse) in
//
//            XCTAssertFalse(success)
//            XCTAssertNil(translateresponse)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.01)
//    }
    

}
