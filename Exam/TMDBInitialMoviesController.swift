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
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .green
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: movieCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellId, for: indexPath) as! MovieCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 150)
    }
    
}

class MovieCell:UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init not implemented")
    }
    
    
    func setupViews() {
        backgroundColor = .blue
    }
}
