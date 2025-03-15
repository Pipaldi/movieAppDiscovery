//
//  MovieListViewController.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 15/03/25.
//

import UIKit

final class MovieListViewController: UIViewController {
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        Task { await viewModel.fetchMovies() }
    }
    
    private func setupUI() {
        title = "Movies 24/7"
        view.backgroundColor = .white
        
        // Setup Favorites Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(openFavorites)
        )
        navigationItem.rightBarButtonItem?.tintColor = .red
        
        // Setup search controller
        searchController.searchBar.placeholder = "Search Movies"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        // Setup table view
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        searchController.searchBar.delegate = self
    }
    
    @objc private func openFavorites() {
        let favoritesVC = FavoritesListViewController()
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    private func setupBindings() {
        viewModel.updateHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.handleLoadingState()
                if let errorMessage = self?.viewModel.errorMessage {
                    self?.showErrorAlert(message: errorMessage)
                }
            }
        }
    }
    
    private func handleLoadingState() {
        if viewModel.isLoading {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.startAnimating()
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = viewModel.movies[indexPath.row]
        let detailVC = MovieDetailViewController(movie: selectedMovie)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Task { await viewModel.searchMovies(query: searchText) }
    }
}
