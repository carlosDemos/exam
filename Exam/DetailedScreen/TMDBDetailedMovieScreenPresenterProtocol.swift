//
//  TMDBDetailedMovieScreenPresenterProtocol.swift
//  Exam
//
//  Created by Carlos Caraccia on 09/05/2022.
//

import Foundation

protocol TMDBDetailedMovieScreenPresenterProtocol:AnyObject {
 
    init(webService:TMDBNetworkingServiceProtocol,
         delegate:TMDBDetailedMovieScreenDelegateProtocol)
    
    func getMovieDetails(for movieId:Int)
}
