//
//  TMDBInitialMoviesController.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

class TMDBInitialMoviesController:UICollectionViewController,
                                  UICollectionViewDelegateFlowLayout
{
    weak var delegate:TMDBMainCoordinator?
    
    var presenter:TMDBInitialScreenPresenterProtocol?
        
    private let movieCellId = "movieCellId"
    private let sectionHeaderId = "sectionHeaderId"
    
    private var moviesDictionary:[TMDBServiceEndPoints : [Movie]] = Dictionary() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            presenter = TMDBInitialScreenPresenter(webService: TMDBNetworkingService(),
                                                       delegate: self)
        }
        presenter?.getInitialMovies()

        collectionView.backgroundColor = .white
        collectionView.register(TMDBInitialMoviesCell.self, forCellWithReuseIdentifier: movieCellId)
        collectionView.register(TMDBInitialScreenSectionHeaderTitle.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: sectionHeaderId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellId, for: indexPath) as! TMDBInitialMoviesCell
        let key = Array(moviesDictionary.keys)[indexPath.section]
        let movies = moviesDictionary[key]
        cell.movies = movies
        cell.delegate = self
        return cell
    }
        
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        let keys = Array(moviesDictionary.keys)
        return keys.count

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderTitle = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! TMDBInitialScreenSectionHeaderTitle
        let keys = Array(moviesDictionary.keys)
        sectionHeaderTitle.sectionTitleLabel.text = keys.count == 0 ? "Section title" :
                                                                        keys[indexPath.section].description
        return sectionHeaderTitle
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

extension TMDBInitialMoviesController: TMDBInitialScreenViewDelegateProtocol {
    
    func successfulGetInitialMovies(moviesDictionary: [TMDBServiceEndPoints : [Movie]]) {
        self.moviesDictionary = moviesDictionary
    }
    
    func errorHandler(error: TMDBServiceError) {
        // TODO: Handle error
    }
}

extension TMDBInitialMoviesController:TMDBInitialMoviesCellProtocol {
    
    func navigateToDetailMovies(movie: Movie) {
        delegate?.showDetailedMovieScreen(with: movie)
    }
}

