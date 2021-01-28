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
        let failUrlProvider = CurrencyUrlProviderAlwaysFailMock()
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
    
    func testGivenSimpleRatesWhenGetUsedRateThenGetCorrectResult() {
        let exchangeService = ExchangeRateService()
        exchangeService.rates = ["EUR" : 1 , "USD" : 1.2]
        XCTAssertEqual(exchangeService.usedRate, 1.2)
       
    }
    
    func testGivenComplexRatesWhenGetUsedRateThenGetCorrectResult() {
        let exchangeService = ExchangeRateService()
        exchangeService.rates = ["EUR" : 1.5 , "USD" : 1.2]
        XCTAssertEqual(exchangeService.usedRate, 0.8)
       
    }

    func test_GivenCurrencyEuro_WhenCurrencyCodeEnumerationSwitch_ThenReceiveEUR() {
        let currency : Currency = .euro
        XCTAssertEqual(currency.currencyCode, "EUR")
    }
    
    func test_GivenCurrencySwissFrancs_WhenCurrencyCodeEnumerationSwitch_ThenReceiveCHF(){
        let currency : Currency = .swissFrancs
        XCTAssertEqual(currency.currencyCode, "CHF")
    }
    
    func test_GivenCurrencyDollar_WhenCurrencyCodeEnumerationSwitch_ThenReceiveUSD(){
        let currency : Currency = .usDollar
        XCTAssertEqual(currency.currencyCode, "USD")
    }
    
    func test_GivenSymbolEuro_WhenSymbolEnumerationSwitch_ThenReceiveCorrectSymbol(){
        let symbol : Currency = .euro
        XCTAssertEqual(symbol.symbol , "€")
    }
    
    func test_GivenSymbolSwissFrancs_WhenSymbolEnumerationSwitch_ThenReceiveCorrectSymbol(){
        let symbol : Currency = .swissFrancs
        XCTAssertEqual(symbol.symbol , "CHF")
    }
    
    func test_GivenSymbolUsDollar_WhenSymbolEnumerationSwitch_ThenReceiveCorrectSymbol(){
        let symbol : Currency = .usDollar
        XCTAssertEqual(symbol.symbol , "$")
    }
}
