//
//  CurrencyUrlProviderMock.swift
//  Le BaluchonTests
//
//  Created by Fabien Dietrich on 13/01/2021.
//  Copyright © 2021 Fabien Dietrich. All rights reserved.
//

@testable import Le_Baluchon
import Foundation


class CurrencyUrlProviderAlwazsFailMock: CurrencyUrlProviderProtocol {
    func createExchangeRateRequestUrl() -> URL? {
        return nil
    }
    
    
}
