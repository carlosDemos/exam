//
//  TMDBInitialScreenDataSourceTests.swift
//  ExamTests
//
//  Created by Carlos Caraccia on 12/05/2022.
//

import XCTest
@testable import Exam

class TMDBInitialScreenDataSourceTests: XCTestCase {
    
    var sut:TMDBInitialMoviesDataSource!
    var collectionView:UICollectionView!
    
    override func setUp() {
        
        sut = TMDBInitialMoviesDataSource()
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = sut
        
    }
    
    override func tearDown() {
        sut = nil
        collectionView = nil
    }

    func test_InititalScreenDataSource_WhenNotLoaded_ContainsOneSection() {
        
        XCTAssertEqual(collectionView.numberOfSections, 1)
    }
    
    func test_InititalScreenDataSource_WhenLoadedWithData_ShouldContainOneItemInSection() {
        
        let mockDictionaryWithMovies = MockObjects.moviesDictionaryMock(with: 1)
        sut.moviesDictionary = mockDictionaryWithMovies
        
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 1)
    }
    
    func test_InititalScreenDataSource_WhenLoadedWithData_ItemAndSupplementaryViewInSectionShouldBeOfSpecificType() {
        
        let mockDictionaryWithMovies = MockObjects.moviesDictionaryMock(with: 1)
        sut.moviesDictionary = mockDictionaryWithMovies
        collectionView.register(TMDBInitialMoviesCell.self, forCellWithReuseIdentifier: "movieCellId")
        collectionView.register(TMDBInitialScreenSectionHeaderTitle.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "sectionHeaderId")
                
        collectionView.reloadData()
        let cell  = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as? TMDBInitialMoviesCell
        let suplementaryView  = collectionView.dataSource?.collectionView?(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? TMDBInitialScreenSectionHeaderTitle
        
        XCTAssertNotNil(cell)
        XCTAssertNotNil(suplementaryView)

    }
}
