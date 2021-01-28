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

    func test_GivenLanguageCodeFrench_WhenSymbolEnumerationSwitch_ThenReceiveFR(){
        let languageCode : Language = .french
        XCTAssertEqual(languageCode.languageCode , "FR")
    }
    
    func test_GivenLanguageCodefrench_WhenSymbolEnumerationSwitch_ThenXCTFail(){
        let languageCode : Language = .french
        XCTAssertNotEqual(languageCode.languageCode , "fr")
    }
    
    func test_GivenLanguageCodeEnglish_WhenSymbolEnumerationSwitch_ThenReceiveEN(){
        let languageCode : Language = .english
        XCTAssertEqual(languageCode.languageCode , "EN")
    }
    
    func test_GivenNameEnglish_WhenSymbolEnumerationSwitch_ThenReceiveEnglish(){
        let languageCode : Language = .english
        XCTAssertEqual(languageCode.name , "English")
    }
    
    func test_GivenNameFrench_WhenSymbolEnumerationSwitch_ThenReceiveFrench(){
        let languageCode : Language = .french
        XCTAssertEqual(languageCode.name , "French")
    }
    
    func test_GivenNameenglish_WhenSymbolEnumerationSwitch_ThenXCTFail(){
        let languageCode : Language = .english
        XCTAssertNotEqual(languageCode.languageCode , "english")
    }


}
