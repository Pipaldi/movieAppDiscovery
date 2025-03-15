//
//  movieAppDiscoveryTests.swift
//  movieAppDiscoveryTests
//
//  Created by Luis Fernando AG on 15/03/25.
//

import Testing
import XCTest
@testable import movieAppDiscovery

final class MovieListViewModelTests: XCTestCase {
    private var viewModel: MovieListViewModel!
    private var mockMovieService: MockMovieService!
    
    override func setUp() {
        super.setUp()
        mockMovieService = MockMovieService()
        viewModel = MovieListViewModel(movieService: mockMovieService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockMovieService = nil
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() async {
        mockMovieService.mockMovies = [
            MovieAPIResponse(id: 1, title: "Test Movie", overview: "Overview", releaseDate: "2025-01-01", posterPath: "/test.jpg")
        ]
        
        await viewModel.fetchMovies()
        
        XCTAssertFalse(viewModel.movies.isEmpty)
        XCTAssertEqual(viewModel.movies.count, 1)
        XCTAssertEqual(viewModel.movies.first?.title, "Test Movie")
    }
    
    func testFetchMoviesFailure() async {
        mockMovieService.shouldReturnError = true
        
        await viewModel.fetchMovies()
        
        XCTAssertTrue(viewModel.movies.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testSearchMoviesSuccess() async {
        mockMovieService.mockMovies = [
            MovieAPIResponse(id: 2, title: "Search Result", overview: "Overview", releaseDate: "2025-02-01", posterPath: "/search.jpg")
        ]
        
        await viewModel.searchMovies(query: "Search Result")
        
        XCTAssertFalse(viewModel.movies.isEmpty)
        XCTAssertEqual(viewModel.movies.first?.title, "Search Result")
    }
}

// MARK: - Mock Movie Service
final class MockMovieService: MovieService {
    var mockMovies: [MovieAPIResponse] = []
    var shouldReturnError = false
    
    override func getMovies() async throws -> [MovieAPIResponse] {
        if shouldReturnError {
            throw NetworkError.requestFailed
        }
        return mockMovies
    }
    
    override func searchMovies(query: String) async throws -> [MovieAPIResponse] {
        if shouldReturnError {
            throw NetworkError.requestFailed
        }
        return mockMovies
    }
}

