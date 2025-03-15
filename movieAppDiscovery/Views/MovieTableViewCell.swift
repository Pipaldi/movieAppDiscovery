//
//  MovieTableViewCell.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 15/03/25.
//

import Foundation
import UIKit
final class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    private let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(moviePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        
        NSLayoutConstraint.activate([
            moviePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            moviePosterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moviePosterImageView.widthAnchor.constraint(equalToConstant: 60),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 10),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configure(with movie: MovieAPIResponse) {
        titleLabel.text = movie.title
        releaseDateLabel.text = "Released: \(movie.releaseDate ?? "N/A")"
        
        if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            downloadImage(from: url)
        } else {
            moviePosterImageView.image = UIImage(systemName: "photo")
        }
    }
    
    private func downloadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = image
                }
            }
        }
    }
}
