//
//  TMDBDetailedMovieScreenTests.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 10/05/2022.
//

import XCTest
@testable import Exam

class TMDBDetailedMovieScreenTests: XCTestCase {
    
    var sut:TMDBDetailedMovieScreen!

    override func setUp() {
        sut = TMDBDetailedMovieScreen(movieId: 32)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testTMDBDetailedMovieScreen_WhenViewIsLoaded_GetMovieDetailsIsCalled() {
        
        // Arrange
        let mockWebService = MockTMDBNetworkingService()
        let mockDelegate = MockTMDBDetailedScreenViewDelegate()
        let mockPresenter = MockTMDBDetailedScreenPresenter(webService: mockWebService,
                                                        delegate: mockDelegate)
        sut.presenter = mockPresenter
        
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        XCTAssertTrue(mockPresenter.isGetMovieDetailsCalled, "GetMovieDetails should be called but it was not")
    }

}
