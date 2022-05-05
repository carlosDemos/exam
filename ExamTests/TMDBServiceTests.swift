//
//  TMDBServiceTests.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 05/05/2022.
//

import XCTest
@testable import Exam

class TMDBServiceTests: XCTestCase {

    
    override class func setUp() {
        
    }
    
    override class func tearDown() {
        
    }
    
    func testTMDBfetchMovie_whenGivenRequestWasInCache_NoRequestShouldBeMade() {
        
        // TODO: add another TMDB service tests file split between the cached tests and the non cached tests so we can have a properly sut file added to test everything.
        
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: urlSessionConfiguration)
        let bundle = Bundle(for: TMDBServiceTests.self)
        let url = bundle.url(forResource: "movie_info", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decodedData = try! Utilities.jsonDecoder.decode(Movie.self, from: data)
        let cache = MyCache()
        let apiKey = "1998bfbd5a042c8835abedd2ca3106d4"
        let baseAPIURL = "https://api.themoviedb.org/3"
        let fetchUrl = URL(string: "\(baseAPIURL)/movie/\(338762)")!
        var queryItems = [URLQueryItem(name:"api_key", value: apiKey)]
        let params = ["append_to_response" : "videos,credits"]
        queryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        var urlComponents = URLComponents(url: fetchUrl, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems  = queryItems

        cache.setObject(decodedData as AnyObject, forKey: urlComponents.url!.absoluteString as AnyObject)
        
        let sut = TMDBService(urlSession: session, cache: cache)
        let expectation = self.expectation(description: "TMDBService response expectation")
        
        sut.fetchMovie(id: 338762) { result in
            switch result {
            case .success(let movie):
                XCTAssertEqual(movie.id, 338762, "The movies id should be equal but they are not")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        self.wait(for: [expectation], timeout: 0.1)

    }
    
    func testTMDBfetchMovie_whenGivenInvalidData_shouldReturnError() {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: urlSessionConfiguration)
        let stubResponse = HTTPURLResponse(url: URL(string: "aaa")!, statusCode: 210, httpVersion: nil, headerFields: nil)
        let data = "{\"path\" : \"incorrect\"}".data(using: .utf8)
        MockURLProtocol.stubResponseData = data
        MockURLProtocol.stubURLResponse = stubResponse
        let sut = TMDBService(urlSession: session)
        let expectation = self.expectation(description: "TMDBService response expectation")
        
        sut.fetchMovie(id: 338762) { result in
            switch result {
            case .success(let movie):
                XCTAssertNil(movie)
            case .failure(let error):
                XCTAssertEqual(error.localizedDescrition, "The data was invalid", "The returning error should be Invalid data but it was not.")
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 0.1)

    }
    
    func testTMDBfetchMovie_whenGivenAnInvalidStatusCode_shouldReturnError() {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: urlSessionConfiguration)
        let stubResponse = HTTPURLResponse(url: URL(string: "aaa")!, statusCode: 410, httpVersion: nil, headerFields: nil)
        MockURLProtocol.stubURLResponse = stubResponse
        let sut = TMDBService(urlSession: session)
        let expectation = self.expectation(description: "TMDBService response expectation")
        
        sut.fetchMovie(id: 338762) { result in
            switch result {
            case .success(let movie):
                XCTAssertNil(movie)
            case .failure(let error):
                XCTAssertEqual(error.localizedDescrition, "Invalid response", "The returning error should be Invalid response but it was not.")
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 5.0)
    }
    
    func testTMDBfetchMovie_whenGivenASuccessfulResponse_shouldReturnSuccess() {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: urlSessionConfiguration)
        let bundle = Bundle(for: TMDBServiceTests.self)
        let url = bundle.url(forResource: "movie_info", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let stubResponse = HTTPURLResponse(url: URL(string: "aaa")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        MockURLProtocol.stubURLResponse = stubResponse
        MockURLProtocol.stubResponseData = data
        let sut = TMDBService(urlSession: session)
        let expectation = self.expectation(description: "TMDBService response expectation")
        
        sut.fetchMovie(id: 338762) { result in
            switch result {
            case .success(let movie):
                XCTAssertEqual(movie.id, 338762, "The movies id should be equal but they are not")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
}
