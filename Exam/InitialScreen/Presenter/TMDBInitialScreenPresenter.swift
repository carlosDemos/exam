//
//  TMDBInitialScreenPresenter.swift
//  Exam
//
//  Created by Carlos Caraccia on 07/05/2022.
//

import Foundation

class TMDBInitialScreenPresenter: TMDBInitialScreenPresenterProtocol {
    
    private var webService:TMDBNetworkingServiceProtocol
    private weak var delegate:TMDBInitialScreenViewDelegateProtocol?
    
    required init(webService:TMDBNetworkingServiceProtocol,
         delegate:TMDBInitialScreenViewDelegateProtocol) {
        self.webService = webService
        self.delegate = delegate
    }
    
    func getInitialMovies() {
        webService.getInitialMovies { result in
            switch result {
            case .success(let moviesDictionary):
                self.delegate?.successfulGetInitialMovies(moviesDictionary: moviesDictionary)
            case .failure(let serviceError):
                self.delegate?.errorHandler(error: serviceError)
            }
        }
    }
}
