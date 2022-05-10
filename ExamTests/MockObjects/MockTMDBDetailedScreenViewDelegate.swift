//
//  MockTMDBDetailedScreenViewDelegate.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 10/05/2022.
//

import Foundation
@testable import Exam
import XCTest

class MockTMDBDetailedScreenViewDelegate:TMDBDetailedMovieScreenDelegateProtocol {
    
    var expectation:XCTestExpectation?
    
    func successfulGetMovieDetails(movie: Movie) {
        expectation?.fulfill()
    }
    
    func errorHandler(error: TMDBServiceError) {
        
    }
    
}
