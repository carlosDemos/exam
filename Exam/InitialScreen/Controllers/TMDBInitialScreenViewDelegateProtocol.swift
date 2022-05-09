//
//  TMDBInitialScreenViewDelegateProtocol.swift
//  Exam
//
//  Created by Carlos Caraccia on 07/05/2022.
//

import Foundation

protocol TMDBInitialScreenViewDelegateProtocol:AnyObject {
    
    func successfulGetInitialMovies(moviesDictionary:[TMDBServiceEndPoints:[Movie]])
    func errorHandler(error:TMDBServiceError)
    
}
