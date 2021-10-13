
import Foundation


class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?) )?
    
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override func stopLoading() {
        
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            print("❌❌ HANDLER NIL")
            client?.urlProtocol(self, didFailWithError: MockError.test)
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                print("DATA 🤣🤣")
                client?.urlProtocol(self, didLoad: data)
            }

            print("🍅WILL FINISH LOADIING-----------------------------")
            
            client?.urlProtocolDidFinishLoading(self)
        } catch  {
            print("CATCH ERROR 🇺🇸")
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}


enum MockError: Error {
case test
}

