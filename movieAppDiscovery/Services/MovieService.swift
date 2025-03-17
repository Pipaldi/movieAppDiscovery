//
//  MovieService.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 15/03/25.
//

import Foundation
protocol MovieServiceProtocol {
    func getMovies() async throws -> [MovieAPIResponse]
    func searchMovies(query: String) async throws -> [MovieAPIResponse]
}
final class MovieService : MovieServiceProtocol {
    private let apiKey = "cdd3218e1e2f7ae46be3c92cf17fa715"
    private let baseURL = "https://api.themoviedb.org/3"
    private let networkManager: NetworkServiceProtocol
    
    init(networkManager: NetworkServiceProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getMovies() async throws -> [MovieAPIResponse] {
        guard let url = URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)") else {
            throw NetworkError.badURL
        }
        
        let movieResponse: MovieResponse = try await networkManager.fetch(url: url)
        return movieResponse.results
    }

    func searchMovies(query: String) async throws -> [MovieAPIResponse] {
        guard let url = URL(string: "\(baseURL)/search/movie?query=\(query)&api_key=\(apiKey)") else {
            throw NetworkError.badURL
        }

        let movieResponse: MovieResponse = try await networkManager.fetch(url: url) 
        return movieResponse.results
    }

}
