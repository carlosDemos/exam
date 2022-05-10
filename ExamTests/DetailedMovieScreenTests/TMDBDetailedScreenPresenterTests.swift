//
//  TMDBDetailedScreenPresenterTests.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 10/05/2022.
//

import XCTest
@testable import Exam

class TMDBDetailedScreenPresenterTests: XCTestCase {

    func testTMDBDetailedScreenPresenter_WhenGivenAnEndPoint_ShouldCallGetMoviesMethodOnNetworkingClass() {
        
        // arrange
        let mockTMDBPNetworkingService = MockTMDBNetworkingService()
        let mockTMDBDetailedScreenViewDelegate = MockTMDBDetailedScreenViewDelegate()
        
        let sut = TMDBDetailedMovieScreenPresenter(webService:mockTMDBPNetworkingService,
                                                   delegate: mockTMDBDetailedScreenViewDelegate)
        
        // act
        sut.getMovieDetails(for: 1)
        
        // asert
        XCTAssertFalse(mockTMDBPNetworkingService.isGetInitialMoviesCalled,
                      "TMDBNetworkingService isGetMoviesCalled should be true but it was not.")
        XCTAssertTrue(mockTMDBPNetworkingService.isFetchMovieCalled,
                       "TMDBNetworkingService isFetchMovieCalled should be true but it was not.")
        XCTAssertFalse(mockTMDBPNetworkingService.isSearchMovieCalled,
                       "TMDBNetworkingService isSearchMovieCalled should be true but it was not.")
    }
    
    func testTMDBDetailedScreenPresenter_WhenGetMoviesOperationIsSuccessfull_CallSucceedsOnViewDelegateMethod() {
        
        // arrange
        let successfullGetMovieExpectation = expectation(description: "Expect a successful get movies method to be called on the presenter")
        let mockTMDBDetailedScreenViewDelegate = MockTMDBDetailedScreenViewDelegate()
        mockTMDBDetailedScreenViewDelegate.expectation = successfullGetMovieExpectation
        
        let mockTMDBNetworkingService = MockTMDBNetworkingService()
        
        // act
        let sut = TMDBDetailedMovieScreenPresenter(webService: mockTMDBNetworkingService,
                                             delegate: mockTMDBDetailedScreenViewDelegate)
        
        sut.getMovieDetails(for: 1)
        
        // assert
        self.wait(for: [successfullGetMovieExpectation], timeout: 1.0)

        
    }

    
}
