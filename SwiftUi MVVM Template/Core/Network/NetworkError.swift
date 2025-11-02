//
//  NetworkError.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 18/10/25.
//

import Foundation

/// Errors produced by the networking layer. These are low-level and are
/// typically mapped to user-friendly messages via `AppError.map(_:)`.
enum NetworkError: Error, LocalizedError, Sendable {
    case invalidURL
    case encodingFailed
    case decodingFailed
    case noData
    case invalidResponse
    case httpError(statusCode: Int, message: String)
    case custom(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .encodingFailed:
            return "Failed to encode the request body."
        case .decodingFailed:
            return "Failed to decode the server response."
        case .noData:
            return "No data received from server."
        case .invalidResponse:
            return "The server response was invalid."
        case .httpError(let statusCode, let message):
            return "HTTP Error \(statusCode): \(message)"
        case .custom(let error):
            return error.localizedDescription
        }
    }
}
