//
//  TMDBCacheTests.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 06/05/2022.
//

import XCTest
@testable import Exam

class TMDBCacheTests: XCTestCase {

    // TODO: create a proper sut with setups and teardowns
    
    func testTMDBfetchMovie_whenGivenRequestWasInCache_NoRequestShouldBeMade() {
                
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: urlSessionConfiguration)
        let bundle = Bundle(for: TMDBNetworkingTests.self)
        let url = bundle.url(forResource: "movie_info", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decodedData = try! TMDBUtilities.jsonDecoder.decode(Movie.self, from: data)
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

}
