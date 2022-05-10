//
//  MockObjects.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 10/05/2022.
//

import Foundation
@testable import Exam

class MockObjects {
    
    class func movieMock(withId id:Int) -> Movie {
        
        let movie = Movie(id: id,
                          title: "a title",
                          backdropPath: "back drop path",
                          posterPath: "a poster path",
                          overview: "an overview",
                          voteAverage: 25.0,
                          voteCount: 1,
                          runtime: 1)
        return movie
        
        
    }
    
    class func moviesDictionaryMock(with id:Int) -> [TMDBServiceEndPoints:[Movie]] {
        
        let movie = movieMock(withId: id)
        let dict:[TMDBServiceEndPoints:[Movie]] = [.popular:[movie],
                                                   .topRated:[movie],
                                                   .upcoming:[movie]]
        return dict
    }
    
}
