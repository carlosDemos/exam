//
//  TMDBInitialMoviesController.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

class TMDBInitialMoviesController:UIViewController
                                  
{
    weak var delegate:TMDBInitialScreenCoordinator?
    
    var presenter:TMDBInitialScreenPresenterProtocol?
        
    var dataSource:TMDBInitialMoviesDataSource? {
        didSet {
            collectionView.dataSource = dataSource
            collectionView.reloadData()
        }
    }
    
    var collectionViewDelegate:TMDBInitialScreenCollectoinViewDelegate? {
        didSet {
            collectionView.delegate = collectionViewDelegate
        }
    }
    
    var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureCollectionView()
        
        if presenter == nil {
            presenter = TMDBInitialScreenPresenter(webService: TMDBNetworkingService(),
                                                   delegate: self)
        }
        presenter?.getInitialMovies()
    }
    
    func configureCollectionView() {
        
        collectionView.backgroundColor = .white
        collectionView.register(TMDBInitialMoviesCell.self,
                                forCellWithReuseIdentifier: movieCellId)
        collectionView.register(TMDBInitialScreenSectionHeaderTitle.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: sectionHeaderId)
                
        collectionView.dataSource = self.dataSource
        collectionView.delegate = self.collectionViewDelegate
    }
    
    func setupViews() {
    
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        ])
    }
}

extension TMDBInitialMoviesController: TMDBInitialScreenViewDelegateProtocol {
    
    func successfulGetInitialMovies(moviesDictionary: [TMDBServiceEndPoints : [Movie]]) {
        
        let datasoure = TMDBInitialMoviesDataSource()
        datasoure.moviesDictionary = moviesDictionary
        datasoure.delegate = self
        self.dataSource = datasoure
        
        self.collectionViewDelegate = TMDBInitialScreenCollectoinViewDelegate()
    }
    
    func errorHandler(error: TMDBServiceError) {
        // TODO: Handle error
    }
}

extension TMDBInitialMoviesController: TMDBInitialMoviesDataSourceDelegateProtocol {
    func didSelectMovie(movie: Movie) {
        delegate?.showDetailedMovieScreen(with: movie)
    }
}


