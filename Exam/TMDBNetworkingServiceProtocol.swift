//
//  TMDBNetworkingServiceProtocol.swift
//  Exam
//
//  Created by Carlos Caraccia on 06/05/2022.
//

import Foundation

protocol TMDBNetworkingServiceProtocol {
    
    func getMovies(from endPoint:TMDBServiceEndPoints, completion: @escaping (Result<MovieApiResponse, TMDBServiceError>) -> Void)
    func fetchMovie(id:Int, completion:@escaping(Result<Movie, TMDBServiceError>) -> Void)
    func searchMovie(query: String, completion: @escaping (Result<MovieApiResponse, TMDBServiceError>) -> Void)
    
}
