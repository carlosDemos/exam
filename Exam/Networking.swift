//
//  Networking.swift
//  Exam
//
//  Created by Carlos Caraccia on 04/05/2022.
//

import Foundation

protocol MovieService {
    
    func getMovies(from endPoint:MovieListEndPoint, completion: @escaping (Result<MovieApiResponse, NetworkingError>) -> ())
    func fetchMovie(id:Int, completion:@escaping(Result<Movie, NetworkingError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieApiResponse, NetworkingError>) -> ())
    
}

enum MovieListEndPoint:String {
    
    case upcomming
    case popular
    case topRated = "top_rated"
    
    var description:String {
        
        switch self {
            case .popular: return "Popular"
            case .topRated: return "Top Rated"
            case .upcomming: return "Upcomming"
        }
    }
}

enum NetworkingError:Error {
    
    case serviceError
    case incorrectEndPoint
    case invalidResponse
    case invalidData
    
    var localizedDescrition:String {
        
        switch self {
            case .serviceError: return "Failied fetching data"
            case .incorrectEndPoint: return "The endpoint is incorrect"
            case .invalidResponse: return "Invalid response"
            case .invalidData: return "The data was invalid"
        }
    }
    
    var errorUserInfo:[String:Any] {
        [NSLocalizedDescriptionKey : localizedDescrition]
    }
}
