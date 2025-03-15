//
//  NetworkServiceProtocol.swift
//  movieAppDiscovery
//
//  Created by Luis Fernando AG on 15/03/25.
//

import Foundation
protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(url: URL) async throws -> T
}
