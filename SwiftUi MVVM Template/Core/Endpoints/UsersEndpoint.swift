//
//  UsersEndpoint.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 23/10/25.
//

import Foundation

/// Endpoint descriptions for users-related API calls. Conforms to `APIEndpoint`.
enum UsersEndpoint: APIEndpoint {
    
    case usersList
    case userDetails(Int)

    // MARK: - Path
    var path: String {
        switch self {
        case .usersList:
            return "/users"
        case .userDetails(let id):
            return "/users/\(id)"
        }
    }

    // MARK: - Method
    var method: HTTPMethod {
        .GET
    }

    // MARK: - Headers
    var headers: HTTPHeaders? {
        .default
    }

    // MARK: - Query Params
    var queryItems: [URLQueryItem]? {
        nil
    }

    // MARK: - Body
    var body: RequestBody? {
        nil
    }
}
