//
//  MockTMDBNetworkingService.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 07/05/2022.
//

import Foundation
@testable import Exam

class MockTMDBNetworkingService:TMDBNetworkingServiceProtocol {
    
    var isGetInitialMoviesCalled:Bool = false
    var isFetchMovieCalled:Bool = false
    var isSearchMovieCalled:Bool = false
    
    func getInitialMovies(completion: @escaping (Result<[TMDBServiceEndPoints : [Movie]], TMDBServiceError>) -> Void) {
        
        isGetInitialMoviesCalled = true

        let dict = MockObjects.moviesDictionaryMock(with: 1)
        
        completion(.success(dict))
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, TMDBServiceError>) -> Void) {
        isFetchMovieCalled = true
        
        let movie = MockObjects.movieMock(withId: 1)
        
        completion(.success(movie))

    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieApiResponse, TMDBServiceError>) -> Void) {
        isSearchMovieCalled = true
    }

}
