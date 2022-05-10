//
//  TMDBInitialScreenTests.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 09/05/2022.
//

import XCTest
@testable import Exam

class TMDBInitialScreenTests: XCTestCase {

    var sut:TMDBInitialMoviesController!
    
    override func setUp() {
        let layout = UICollectionViewFlowLayout()
        sut = TMDBInitialMoviesController(collectionViewLayout: layout)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testTMDBInitialScreen_WhenViewIsLoaded_InvokesGetInitialMoviesInWebService () {
        // Arrange
        let mockWebService = MockTMDBNetworkingService()
        let mockDelegate = MockTMDBInitialScreenViewDelegate()
        let mockPresenter = MockTMDBInitialScreenPresenter(webService: mockWebService,
                                                        delegate: mockDelegate)
        sut.presenter = mockPresenter
        
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        XCTAssertTrue(mockPresenter.getInitialMoviesCalled, "Get initial movies should be called but it was not.")
    }
    
}
