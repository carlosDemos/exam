//
//  TMDBDetailedMovieScreen.swift
//  Exam
//
//  Created by Carlos Caraccia on 04/05/2022.
//

import UIKit

class TMDBDetailedMovieScreen: UIViewController  {
    
    weak var delegate:TMDBInitialScreenCoordinator?
    
    private var movieId:Int
    
    private var movie:Movie? {
        didSet {
            movieImage.loadImage(with: movie!.backDropUrl)
            movieTitleLabel.text = movie?.title
            movieDescriptionLabel.text = movie?.overview
            movieVotesLabel.text = "Votes \(movie!.voteAverage)"
        }
    }
    
    var presenter:TMDBDetailedMovieScreenPresenterProtocol?
        
    init(movieId:Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var movieImage:TMDBImageLoader = {
        let iv = TMDBImageLoader()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var movieTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "The adam project"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 30, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieDescriptionLabel:UILabel = {
        let label = UILabel()
        label.text = "The adam project"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieVotesLabel:UILabel = {
        let label = UILabel()
        label.text = "The adam project"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            presenter = TMDBDetailedMovieScreenPresenter(webService: TMDBNetworkingService(),
                                                             delegate: self)
        }
        view.backgroundColor = .white
        presenter?.getMovieDetails(for: movieId)
        setupViews()
    }
        
    func setupViews() {
        
        let stackView = UIStackView(arrangedSubviews: [movieImage,
                                                       movieTitleLabel,
                                                       movieDescriptionLabel,
                                                       movieVotesLabel])
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -8)
        ])
    }
}

extension TMDBDetailedMovieScreen: TMDBDetailedMovieScreenDelegateProtocol {
    func successfulGetMovieDetails(movie: Movie) {
        self.movie = movie
    }
    
    func errorHandler(error: TMDBServiceError) {
        // TODO: handle error correctly
    }
}

