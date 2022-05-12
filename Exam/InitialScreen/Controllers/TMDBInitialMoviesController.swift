//
//  TMDBInitialMoviesController.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import Foundation
import UIKit

let movieCellId = "movieCellId"
let sectionHeaderId = "sectionHeaderId"

class TMDBInitialMoviesController:UIViewController,
                                  UICollectionViewDelegateFlowLayout
{
    weak var delegate:TMDBMainCoordinator?
    
    var presenter:TMDBInitialScreenPresenterProtocol?
        
    private let movieCellId = "movieCellId"
    private let sectionHeaderId = "sectionHeaderId"
    
    var dataSource:TMDBInitialMoviesDataSource? {
        didSet {
            collectionView.dataSource = dataSource
            collectionView.reloadData()
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
        collectionView.delegate = self
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}

extension TMDBInitialMoviesController: TMDBInitialScreenViewDelegateProtocol {
    
    func successfulGetInitialMovies(moviesDictionary: [TMDBServiceEndPoints : [Movie]]) {
        let datasoure = TMDBInitialMoviesDataSource()
        datasoure.moviesDictionary = moviesDictionary
        datasoure.delegate = self
        self.dataSource = datasoure
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


