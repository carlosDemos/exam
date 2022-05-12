//
//  TMDBInitialMoviesDataSource.swift
//  Exam
//
//  Created by Carlos Caraccia on 11/05/2022.
//

import Foundation
import UIKit

protocol TMDBInitialMoviesDataSourceDelegateProtocol:AnyObject {
    
    func didSelectMovie(movie:Movie)
}

class TMDBInitialMoviesDataSource: NSObject, UICollectionViewDataSource {
    
    //TODO: Create a new delegate method and removed this delegate away from this class, the data source should not be responsible for handling navigation.
    weak var delegate:TMDBInitialMoviesDataSourceDelegateProtocol?
    
    var moviesDictionary:[TMDBServiceEndPoints:[Movie]]?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return moviesDictionary != nil ? Array(moviesDictionary!.keys).count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderTitle = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! TMDBInitialScreenSectionHeaderTitle
        if let moviesDictionary = moviesDictionary {
            let keys = Array(moviesDictionary.keys)
            sectionHeaderTitle.sectionTitleLabel.text = keys.count == 0 ? "Section title" :
                                                                            keys[indexPath.section].description
            return sectionHeaderTitle
        }
        return sectionHeaderTitle
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellId, for: indexPath) as! TMDBInitialMoviesCell
        if let moviesDictionary = moviesDictionary {
            let key = Array(moviesDictionary.keys)[indexPath.section]
            let movies = moviesDictionary[key]
            cell.movies = movies
            cell.delegate = self
            return cell
        }
        return cell
    }

}

extension TMDBInitialMoviesDataSource:TMDBInitialMoviesCellProtocol {
    
    func navigateToDetailMovies(movie: Movie) {
        delegate?.didSelectMovie(movie: movie)
    }
}

