
@testable import Le_Baluchon
import Foundation


class CurrencyUrlProviderAlwaysFailMock: CurrencyUrlProviderProtocol {
    func createExchangeRateRequestUrl() -> URL? {
        return nil
    }
    
    
}
