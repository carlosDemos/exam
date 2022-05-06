//
//  MockUrlProtocol.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 06/05/2022.
//

import Foundation

class MockURLProtocol:URLProtocol {
    
    static var stubResponseData:Data?
    static var stubURLResponse:URLResponse?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        self.client?.urlProtocol(self, didReceive: MockURLProtocol.stubURLResponse ?? URLResponse(), cacheStoragePolicy: .allowed)
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
