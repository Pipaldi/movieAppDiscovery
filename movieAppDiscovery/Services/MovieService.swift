//
//  MovieService.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 15/03/25.
//

import Foundation
class MovieService {
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
            return try await fetchMovies(url: url)
        }
        
        func searchMovies(query: String) async throws -> [MovieAPIResponse] {
            guard let url = URL(string: "\(baseURL)/search/movie?query=\(query)&api_key=\(apiKey)") else {
                throw NetworkError.badURL
            }
            return try await fetchMovies(url: url)
        }
        
        private func fetchMovies(url: URL) async throws -> [MovieAPIResponse] {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                return movieResponse.results
            } catch {
                throw NetworkError.decodingFailed
            }
        }
}
