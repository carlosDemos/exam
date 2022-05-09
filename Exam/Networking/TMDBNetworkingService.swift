//
//  TMDBNetworkingService.swift
//  Exam
//
//  Created by Carlos Caraccia on 06/05/2022.
//

import Foundation

class TMDBNetworkingService: TMDBNetworkingServiceProtocol {

    private let apiKey = "1998bfbd5a042c8835abedd2ca3106d4"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private var urlSession:URLSession
    private var jsonDecoder = TMDBUtilities.jsonDecoder
    private var cache:MyCache
    
    private var initialMoviesDictionary = [TMDBServiceEndPoints:[Movie]]()

    init(urlSession:URLSession = .shared, cache:MyCache = .sharedInstance) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    func getInitialMovies(completion: @escaping(Result<[TMDBServiceEndPoints:[Movie]], TMDBServiceError>) -> Void) {
        getMovies(from: .popular) { popularMoviesResult in
            switch popularMoviesResult {
            case .success(let popularMovies):
                self.initialMoviesDictionary.updateValue(popularMovies.results,
                                                         forKey: .popular)
                self.getMovies(from: .topRated) {topRatedMoviesResult in
                    switch topRatedMoviesResult {
                    case .success(let topRatedMovies):
                        self.initialMoviesDictionary.updateValue(topRatedMovies.results,
                                                                 forKey: .topRated)
                        self.getMovies(from: .upcoming) { upCommingMoviesResult in
                            switch upCommingMoviesResult {
                            case .success(let upCommingMovies):
                                self.initialMoviesDictionary.updateValue(upCommingMovies.results,
                                                                    forKey:.upcoming)
                                completion(.success(self.initialMoviesDictionary))
                            case .failure(let upcommingMoviesError):
                                completion(.failure(upcommingMoviesError))
                            }
                        }
                    case .failure(let topRatedMoviesError):
                        completion(.failure(topRatedMoviesError))
                    }
                }
            case .failure(let popularMoviesError):
                completion(.failure(popularMoviesError))
            }
        }
    }
    
    private func getMovies(from endPoint: TMDBServiceEndPoints, completion: @escaping (Result<MovieApiResponse, TMDBServiceError>) -> Void) {
        guard let safeURL = URL(string: "\(baseAPIURL)/movie/\(endPoint.rawValue)") else {
            completion(.failure(.incorrectEndPoint))
            return
        }
        self.loadAndDecodeURL(url: safeURL, completion: completion)
    }

    func fetchMovie(id: Int, completion: @escaping (Result<Movie, TMDBServiceError>) -> Void) {
        
        guard let safeURL = URL(string: "\(baseAPIURL)/movie/\(id)") else {
            completion(.failure(.incorrectEndPoint))
            return
        }
        
        let fetchMovieParams = ["append_to_response" : "videos,credits"]
        self.loadAndDecodeURL(url: safeURL,params: fetchMovieParams, completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieApiResponse, TMDBServiceError>) -> Void) {
        
        guard let safeURL = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.incorrectEndPoint))
            return
        }
        
        let searchMovieParams = ["language" : "es-AR",
                                 "include_adult" : "false",
                                 "region" : "US",
                                 "query" : query]
        
        self.loadAndDecodeURL(url: safeURL, params: searchMovieParams, completion: completion)
    }
        
    private func loadAndDecodeURL<T: Decodable>(url:URL, params:[String:String]? = nil, completion:@escaping (Result<T, TMDBServiceError>) -> Void) {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.incorrectEndPoint))
            return
        }
        
        var queryItems = [URLQueryItem(name:"api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems  = queryItems
        
        guard let composedURL = urlComponents.url else {
            completion(.failure(.incorrectEndPoint))
            return
        }
        
        if let responseFromCache = cache.object(forKey: composedURL.absoluteString as AnyObject) as? T {
            completion(.success(responseFromCache))
            return
        }
        
        self.urlSession.dataTask(with: composedURL) {(data, response, error) in
            if error != nil {
                self.dispatchResultToMainThread(with: .failure(.serviceError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.dispatchResultToMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let safeData = data else {
                self.dispatchResultToMainThread(with: .failure(.invalidData), completion: completion)
                return
            }
            
            do {
                let decodedData = try self.jsonDecoder.decode(T.self, from: safeData)
                if composedURL.absoluteString.contains("query") {
                    self.cache.setObject(decodedData as AnyObject, forKey:composedURL.absoluteString as AnyObject)
                }
                self.dispatchResultToMainThread(with: .success(decodedData), completion: completion)
            } catch {
                self.dispatchResultToMainThread(with: .failure(.invalidData), completion: completion)
            }
            
        }.resume()
    }
    
    private func dispatchResultToMainThread<T:Decodable> (with result: Result<T, TMDBServiceError>, completion: @escaping(Result<T, TMDBServiceError>) -> Void) {
        DispatchQueue.main.async { completion(result) }
    }
}

class MyCache: NSCache <AnyObject,AnyObject>
{
     static let sharedInstance = MyCache()
}
