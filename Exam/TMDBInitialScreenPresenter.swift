//
//  TMDBInitialScreenPresenter.swift
//  Exam
//
//  Created by Carlos Caraccia on 07/05/2022.
//

import Foundation

class TMDBInitialScreenPresenter {
    
    private var webService:TMDBNetworkingServiceProtocol
    private weak var delegate:TMDBInitialScreenViewDelegateProtocol?
    
    init(webService:TMDBNetworkingServiceProtocol,
         delegate:TMDBInitialScreenViewDelegateProtocol) {
        self.webService = webService
        self.delegate = delegate
    }
    
    func getMovies(from endPoint:TMDBServiceEndPoints) {
        webService.getMovies(from: endPoint) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.delegate?.successfulGetInitialImages()
            case .failure(let error):
                self?.delegate?.errorHandler(error: error)
            }
        }
    }
    
}
