//
//  MovieListViewModelProtocol.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 16/03/25.
//

import Foundation
protocol MovieListViewModelProtocol {
    var movies: [MovieAPIResponse] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var updateHandler: (() -> Void)? { get set }

    func fetchMovies() async
    func searchMovies(query: String) async
}
