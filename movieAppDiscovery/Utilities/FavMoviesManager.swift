//
//  FavMoviesManager.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 15/03/25.
//

import Foundation

final class FavMoviesManager {
    static let shared = FavMoviesManager()
    private let favoritesKey = "favoriteMovies"
    
    private init() {}
    
    func getFavorites() -> [MovieAPIResponse] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else { return [] }
        let decoder = JSONDecoder()
        return (try? decoder.decode([MovieAPIResponse].self, from: data)) ?? []
    }
    
    func addFavorite(_ movie: MovieAPIResponse) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == movie.id }) {
            favorites.append(movie)
            saveFavorites(favorites)
        }
    }
    
    func removeFavorite(_ movie: MovieAPIResponse) {
        let favorites = getFavorites().filter { $0.id != movie.id }
        saveFavorites(favorites)
    }
    
    func isFavorite(_ movie: MovieAPIResponse) -> Bool {
        return getFavorites().contains(where: { $0.id == movie.id })
    }
    
    private func saveFavorites(_ favorites: [MovieAPIResponse]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}
