//
//  TMDBDetailedMovieScreenPresenter.swift
//  Exam
//
//  Created by Carlos Caraccia on 09/05/2022.
//

import UIKit

class TMDBDetailedMovieScreenPresenter:TMDBDetailedMovieScreenPresenterProtocol {
    
    private var webService:TMDBNetworkingServiceProtocol
    private weak var delegate:TMDBDetailedMovieScreenDelegateProtocol?
    
    required init(webService:TMDBNetworkingServiceProtocol,
         delegate:TMDBDetailedMovieScreenDelegateProtocol) {
        self.webService = webService
        self.delegate = delegate
    }
    
    func getMovieDetails(for movieId:Int) {
        webService.fetchMovie(id: movieId) { result in
            switch result {
            case .success(let movie):
                self.delegate?.successfulGetMovieDetails(movie: movie)
            case .failure(let error):
                self.delegate?.errorHandler(error: error)
            }
        }
    }
    
}
