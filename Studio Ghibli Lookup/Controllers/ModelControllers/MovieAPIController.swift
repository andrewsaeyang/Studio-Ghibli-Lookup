//
//  MovieAPIController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/3/21.
//

import Foundation
import UIKit

class MovieAPIController{
    
    //The Movie Database API
    //https://api.themoviedb.org/3/movie/76341?api_key=<<api_key>>
    // MARK: - BASEURL
    //https://api.themoviedb.org
    static let baseURL = URL(string: "https://api.themoviedb.org")
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500/")
    
    // MARK: - COMPONENTS
    static let versionComponent = "3"
    static let searchComponent = "search"
    static let movieComponent = "movie"
    
    // MARK: - QUERY ITEMS
    static let apiKeyKey = "api_key"
    static let apiKeyValue = "a0c4dab30fc5e01de42209a6868523d2"
    
    static let searchTermKey = "query"
    
    // MARK: - FETCHES
    static func fetchMovies(with searchTerm: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void){
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        
        // adding components
        let versionURL = baseURL.appendingPathComponent(versionComponent)
        let searchURL = versionURL.appendingPathComponent(searchComponent)
        let movieURL = searchURL.appendingPathComponent(movieComponent)
        
        // adding queries
        var components = URLComponents(url: movieURL, resolvingAgainstBaseURL: true)
        let accessQuery = URLQueryItem(name: apiKeyKey, value: apiKeyValue)
        let searchTermQuery = URLQueryItem(name: searchTermKey, value: searchTerm)
        
        components?.queryItems = [accessQuery, searchTermQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
        print(finalURL)
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do{
                let MovieTL = try JSONDecoder().decode(MovieTopLevelObject.self, from: data)
                completion(.success(MovieTL.results))
            }catch{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.unableToDecode))
            }
            
        }
        task.resume()
    }
    
    static func fetchMoviePoster(with url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void){
        
        guard let imageBaseURL = imageBaseURL else { return completion(.failure(.invalidURL))}
        let finalURL = imageBaseURL.appendingPathComponent(url.absoluteString)
        
        print(finalURL)
        let task = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.invalidURL))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200
                {
                    print("STATUS CODE: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            completion(.success(image))
            
            
        }
        task.resume()
        
        
    }
    
}
