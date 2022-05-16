//
//  TMDBMovieCell.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import UIKit

class TMDBMovieCell:UICollectionViewCell {
    
    var movie:Movie? {
        didSet {
            movieTitleLabel.text = movie?.title
            if let movieImageUrl = movie?.posterPathURL {
                movieImage.loadImage(with: movieImageUrl)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var movieImage:TMDBImageLoader = {
        let iv = TMDBImageLoader()
        iv.image = UIImage(named: "fakeImage")
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
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        
        addSubview(movieImage)
        addSubview(movieTitleLabel)
        
        NSLayoutConstraint.activate([
            movieImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            movieImage.topAnchor.constraint(equalTo: self.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: self.movieTitleLabel.topAnchor, constant: 8),
            movieImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            movieImage.heightAnchor.constraint(equalToConstant: self.frame.height - 32)
        ])
        
        NSLayoutConstraint.activate([
           movieTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
           movieTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
           movieTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])

    }
    
}


