@testable import Le_Baluchon
import Foundation

class TranslateUrlProviderAlwaysFailMock: TranslateUrlProviderProtocol {
    func createTranslateRequestUrl(textToTranslate: String, targetLanguage: String, sourceLanguage: String) -> URL? {
        return nil
    }
}

