//
//  APIEndpoint.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 16/10/25.
//

import Foundation

/// Shared API constants (base url for the sample API used by the template).
enum APIConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
}

/// Represents an API endpoint in a declarative way so the `RequestBuilder`
/// can construct a `URLRequest` from it.
protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: RequestBody? { get }
}

extension APIEndpoint {
    var baseURL: String {
        APIConstants.baseURL
    }
}
