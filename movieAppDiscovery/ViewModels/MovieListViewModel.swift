//
//  MovieListViewModel.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 15/03/25.
//

import Foundation
class MovieListViewModel {
    var movies: [MovieAPIResponse] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let movieService: MovieService
    var updateHandler: (() -> Void)?
    
    init(movieService: MovieService = MovieService()) {
        self.movieService = movieService
    }
    
    func fetchMovies() async {
        isLoading = true
        errorMessage = nil
        updateHandler?()
        
        do {
            let fetchedMovies = try await movieService.getMovies()
            movies = fetchedMovies
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
        updateHandler?()
    }
    
    func searchMovies(query: String) async {
        guard !query.isEmpty else {
            await fetchMovies()
            return
        }
        
        isLoading = true
        errorMessage = nil
        updateHandler?()
        
        do {
            let searchedMovies = try await movieService.searchMovies(query: query)
            movies = searchedMovies
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
        updateHandler?()
    }
}

