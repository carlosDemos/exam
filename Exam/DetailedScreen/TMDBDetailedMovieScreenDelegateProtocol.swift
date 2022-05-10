//
//  TMDBDetailedMovieScreenDelegateProtocol.swift
//  Exam
//
//  Created by Carlos Caraccia on 09/05/2022.
//

import Foundation

protocol TMDBDetailedMovieScreenDelegateProtocol:AnyObject {
    func successfulGetMovieDetails(movie:Movie)
    func errorHandler(error:TMDBServiceError)
}
