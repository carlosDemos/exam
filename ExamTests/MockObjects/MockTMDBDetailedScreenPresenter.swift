//
//  MockTMDBDetailedScreenPresenter.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 10/05/2022.
//

import Foundation
@testable import Exam

class MockTMDBDetailedScreenPresenter:TMDBDetailedMovieScreenPresenterProtocol {
    
    var isGetMovieDetailsCalled = false
    
    required init(webService: TMDBNetworkingServiceProtocol, delegate: TMDBDetailedMovieScreenDelegateProtocol) {
        
    }
    
    func getMovieDetails(for movieId: Int) {
        isGetMovieDetailsCalled = true
    }
    
    
    
}
