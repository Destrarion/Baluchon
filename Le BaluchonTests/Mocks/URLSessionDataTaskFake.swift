
import Foundation


class URLSessionDataTaskFake: URLSessionDataTask {
    init(completionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil, data: Data? = nil, urlResponse: URLResponse? = nil, responseError: Error? = nil) {
        self.completionHandler = completionHandler
        self.data = data
        self.urlResponse = urlResponse
        self.responseError = responseError
    }
    
    var completionHandler: ((Data?,URLResponse?, Error?) -> Void)?
    
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
}
