//
//  MockTMDBInitialScreenPresenter.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 09/05/2022.
//

import Foundation
@testable import Exam

class MockTMDBInitialScreenPresenter:TMDBInitialScreenPresenterProtocol {
    
    var getInitialMoviesCalled = false
    
    required init(webService: TMDBNetworkingServiceProtocol, delegate: TMDBInitialScreenViewDelegateProtocol) {
        
    }
    
    func getInitialMovies() {
        
        getInitialMoviesCalled = true
    }
    
    
}
