//
//  URLSessionFake.swift
//  taux de change APITests
//
//  Created by Fabien Dietrich on 30/06/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?){
        self.data = data
        self.response = response
        self.error = error
    }
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        return task
    }

}

class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?,URLResponse?, Error?) -> Void)?
    
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
    
    override func cancel() {}
    
}
