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
        sut = TMDBInitialMoviesController()
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
    
    func testTMDBInitialScreen_WhenSetDataSource_DataSourceShouldBeTheSameAsTheOneInjected() {
        
        let datasource = TMDBInitialMoviesDataSource()
        datasource.moviesDictionary = MockObjects.moviesDictionaryMock(with: 1)
        sut.dataSource = datasource
        
        sut.loadViewIfNeeded()

        XCTAssertTrue(sut.collectionView.dataSource === datasource)
    }
    
    func testTMDBInitialScreen_WhenLoaded_ShouldContainOneSection() {
        // Arrange
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        XCTAssertEqual(sut.collectionView.numberOfSections, 1, "The number of sections in the collection view when it was loaded should be 1")
    }
    
    func testTMDBInitialScreen_WhenLoadedWithMovies_ShouldContainThreeSections() {
        // Arrange
        let datasource = TMDBInitialMoviesDataSource()
        datasource.moviesDictionary = MockObjects.moviesDictionaryMock(with: 1)
        sut.dataSource = datasource
        
        // Act
        sut.loadViewIfNeeded()
        
        // Assert
        XCTAssertEqual(sut.collectionView.numberOfSections, 3)
    }
    
    func testTMDBInitialScreen_WhenLoadedWithMovies_TheNumberOfItemsInSectionShouldBe1() {
        
        let dataSource = TMDBInitialMoviesDataSource()
        
        sut.loadViewIfNeeded()
        dataSource.moviesDictionary = MockObjects.moviesDictionaryMock(with: 1)
        sut.dataSource = dataSource

        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 1), 1, "The number of items in the section 1 should be 1 but it was not.")
    }
    
}
