//
//  NetworkError.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 15/03/25.
//

import Foundation
enum NetworkError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case unknown(Error)
}
