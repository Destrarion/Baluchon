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
        let result = exchangeService.convertValueWithRate(valueToConvert: 1)
        XCTAssertEqual(result, "$1.20")
       
    }
    
    func testGivenComplexRatesWhenGetUsedRateThenGetCorrectResult() {
        let exchangeService = ExchangeRateService()
        exchangeService.rates = ["EUR" : 1.5 , "USD" : 1.2]
        let result = exchangeService.convertValueWithRate(valueToConvert: 1)
        XCTAssertEqual(result, "$0.80")
       
    }

    func test_GivenCurrencyEuro_WhenCurrencyCodeEnumerationSwitch_ThenReceiveEUR() {
        let currency : Currency = .euro
        XCTAssertEqual(currency.currencyCode, "EUR")
    }
    
    
    func test_GivenCurrencyDollar_WhenCurrencyCodeEnumerationSwitch_ThenReceiveUSD(){
        let currency : Currency = .usDollar
        XCTAssertEqual(currency.currencyCode, "USD")
    }
    
    func test_GivenSymbolEuro_WhenSymbolEnumerationSwitch_ThenReceiveCorrectSymbol(){
        let symbol : Currency = .euro
        XCTAssertEqual(symbol.symbol , "€")
    }
    
    func test_GivenSymbolUsDollar_WhenSymbolEnumerationSwitch_ThenReceiveCorrectSymbol(){
        let symbol : Currency = .usDollar
        XCTAssertEqual(symbol.symbol , "$")
    }
}
