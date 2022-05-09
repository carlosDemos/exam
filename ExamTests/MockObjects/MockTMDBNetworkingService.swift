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

        let movie = Movie(id: 1,
                          title: "a title",
                          backdropPath: "back drop path",
                          posterPath: "a poster path",
                          overview: "an overview",
                          voteAverage: 25.0,
                          voteCount: 1,
                          runtime: 1)
        
        let dict:[TMDBServiceEndPoints:[Movie]] = [.popular:[movie],
                                                   .topRated:[movie],
                                                   .upcoming:[movie]]
            
        let resutlt = Result<[TMDBServiceEndPoints : [Movie]], TMDBServiceError>.success(dict)
        completion(resutlt)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, TMDBServiceError>) -> Void) {
        isFetchMovieCalled = true
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieApiResponse, TMDBServiceError>) -> Void) {
        isSearchMovieCalled = true
    }

}
