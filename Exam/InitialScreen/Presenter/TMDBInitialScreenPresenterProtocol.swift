//
//  TMDBInitialScreenPresenterProtocol.swift
//  Exam
//
//  Created by Carlos Caraccia on 09/05/2022.
//

import Foundation

protocol TMDBInitialScreenPresenterProtocol:AnyObject {
    
    init(webService:TMDBNetworkingServiceProtocol,
         delegate:TMDBInitialScreenViewDelegateProtocol)
    func getInitialMovies()
}

