//
//  TMDBInitialScreenPresenterTests.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 07/05/2022.
//

import XCTest
@testable import Exam

class TMDBInitialScreenPresenterTests: XCTestCase {
    
    func testTMDBPresenter_WhenGivenAnEndPoint_ShouldCallGetMoviesMethodOnNetworkingClass() {
        
        // arrange
        let mockTMDBPNetworkingService = MockTMDBNetworkingService()
        let mockInitialScreenViewDelegate = MockTMDBInitialScreenViewDelegate()
        
        let sut = TMDBInitialScreenPresenter(webService:mockTMDBPNetworkingService,
                                             delegate: mockInitialScreenViewDelegate)
        
        // act
        sut.getInitialMovies()
        
        // asert
        XCTAssertTrue(mockTMDBPNetworkingService.isGetInitialMoviesCalled,
                      "TMDBNetworkingService isGetMoviesCalled should be true but it was not.")
        XCTAssertFalse(mockTMDBPNetworkingService.isFetchMovieCalled,
                       "TMDBNetworkingService isFetchMovieCalled should be true but it was not.")
        XCTAssertFalse(mockTMDBPNetworkingService.isSearchMovieCalled,
                       "TMDBNetworkingService isSearchMovieCalled should be true but it was not.")
    }
    
    func testTMDBInitialScreenPresenter_WhenGetMoviesOperationIsSuccessfull_CallSucceedsOnViewDelegateMethod() {
        
        // arrange
        let successfullGetMoviesExpectation = expectation(description: "Expect a successful get movies method to be called")
        let mockInitialScreenViewDelegate = MockTMDBInitialScreenViewDelegate()
        mockInitialScreenViewDelegate.expectation = successfullGetMoviesExpectation
        
        let mockTMDBNetworkingService = MockTMDBNetworkingService()
        
        // act
        let sut = TMDBInitialScreenPresenter(webService: mockTMDBNetworkingService,
                                             delegate: mockInitialScreenViewDelegate)
        
        sut.getInitialMovies()
        
        // assert
        self.wait(for: [successfullGetMoviesExpectation], timeout: 1.0)

        
    }
    
    // TODO: Add unit test to test error, refactor and remove comments, just show act assert and arrange

}
