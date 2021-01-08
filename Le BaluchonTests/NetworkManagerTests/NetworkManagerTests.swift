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
    
    
}

