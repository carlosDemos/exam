//
//  TMDBInitialScreenViewDelegateProtocol.swift
//  Exam
//
//  Created by Carlos Caraccia on 07/05/2022.
//

import Foundation

protocol TMDBInitialScreenViewDelegateProtocol:AnyObject {
    
    // TODO: pass a parameter to successfulGetInitialImages named movies with the api response from the movies
    
    func successfulGetInitialImages()
    func errorHandler(error:TMDBServiceError)
    
}
