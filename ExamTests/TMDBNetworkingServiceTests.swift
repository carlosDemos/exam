//
//  TMDBNetworkingServiceTests.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 06/05/2022.
//

import XCTest
@testable import Exam

class TMDBNetworkingServiceTests: XCTestCase {
    
    var sut:TMDBNetworkingService!
    var movieFetchedData:Data!
    var searchedMoviesData:Data!
    var initiallyFetchedMoviesData:Data!

    override func setUp() {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: urlSessionConfiguration)
        
        sut = TMDBNetworkingService(urlSession: session)
        
        let bundle = Bundle(for: TMDBNetworkingServiceTests.self)
        let movieInfoUrl = bundle.url(forResource: "movie_info", withExtension: "json")
        let searchedMoviesUrl = bundle.url(forResource: "search_movies", withExtension: "json")
        let initiallyFetchedMoviesUrl = bundle.url(forResource: "movie_list", withExtension: "json")
        movieFetchedData = try! Data(contentsOf: movieInfoUrl!)
        searchedMoviesData = try! Data(contentsOf: searchedMoviesUrl!)
        initiallyFetchedMoviesData = try! Data(contentsOf: initiallyFetchedMoviesUrl!)
    }
        
    override func tearDown() {
        sut = nil
        movieFetchedData = nil
        searchedMoviesData = nil
        initiallyFetchedMoviesData = nil
    }
    
    func testTMDBfetchMovie_whenGivenInvalidData_shouldReturnError() {
        let stubResponse = HTTPURLResponse(url: URL(string: "aaa")!, statusCode: 210, httpVersion: nil, headerFields: nil)
        let corruptedData = "{\"path\" : \"incorrect\"}".data(using: .utf8)
        MockURLProtocol.stubResponseData = corruptedData
        MockURLProtocol.stubURLResponse = stubResponse
        let expectation = self.expectation(description: "TMDBNetworkingService response expectation")
        
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
        
        let stubResponse = HTTPURLResponse(url: URL(string: "aaa")!, statusCode: 410, httpVersion: nil, headerFields: nil)
        MockURLProtocol.stubURLResponse = stubResponse
        let expectation = self.expectation(description: "TMDBNetworkingService response expectation")
        
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
        
        let stubResponse = HTTPURLResponse(url: URL(string: "aaa")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        MockURLProtocol.stubURLResponse = stubResponse
        MockURLProtocol.stubResponseData = movieFetchedData
        
        let expectation = self.expectation(description: "TMDBNetworkingService response expectation")
        
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
