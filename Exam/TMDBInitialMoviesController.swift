//
//  TMDBInitialMoviesController.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

class TMDBInitialMoviesController:UICollectionViewController,
                                  UICollectionViewDelegateFlowLayout {
    
    private let movieCellId = "movieCellId"
    
    private var moviesDictionary:[TMDBServiceEndPoints : [Movie]] = Dictionary() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
       let presenter = TMDBInitialScreenPresenter(webService: TMDBNetworkingService(),
                                                  delegate: self)
        presenter.getInitialMovies()
        
        collectionView.backgroundColor = .white
        collectionView.register(TMDBInitialMoviesCell.self, forCellWithReuseIdentifier: movieCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellId, for: indexPath) as! TMDBInitialMoviesCell
        cell.movies = moviesDictionary[.popular]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 250)
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

