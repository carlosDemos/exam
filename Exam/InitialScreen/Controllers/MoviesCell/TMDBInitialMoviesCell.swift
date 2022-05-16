//
//  TMDBInitialInitialMovieCell.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

protocol TMDBInitialMoviesCellProtocol:AnyObject {
    func navigateToDetailMovies(movie:Movie)
}

class TMDBInitialMoviesCell:UICollectionViewCell,
                            UICollectionViewDataSource,
                            UICollectionViewDelegate,
                            UICollectionViewDelegateFlowLayout
{
    
    private let movieCellIdentifier = "movieCell"
  
    weak var delegate:TMDBInitialMoviesCellProtocol?
    
    var movies:[Movie]? {
        didSet {
            self.moviesCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var moviesCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    func setupViews() {
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        
        moviesCollectionView.register(TMDBMovieCell.self, forCellWithReuseIdentifier:movieCellIdentifier)
                
        addSubview(moviesCollectionView)
        
        NSLayoutConstraint.activate([
            moviesCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            moviesCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            moviesCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let safeMovies = self.movies {
            return safeMovies.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath) as! TMDBMovieCell
        cell.movie = movies?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies![indexPath.row]
        delegate?.navigateToDetailMovies(movie: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: resize the collection view so the images can fit properly
        return CGSize(width: 150, height: moviesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
