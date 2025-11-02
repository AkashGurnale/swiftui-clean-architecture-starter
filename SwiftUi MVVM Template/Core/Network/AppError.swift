//
//  AppError.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import Foundation

/// Application-level error type used to present friendly messages in the UI.
///
/// Low-level errors (URLError, DecodingError, etc.) are mapped to `AppError` via
/// `AppError.map(_:)` to provide consistent, localizable messages for views.
enum AppError: Error, Equatable {
    case network
    case server
    case decoding
    case cancelled
    case unknown(String)
    
    var message: String {
        switch self {
        case .network: return "Network connection seems unstable."
        case .server: return "Server encountered an issue. Please try again."
        case .decoding: return "Received unexpected data format."
        case .cancelled: return "Request was cancelled."
        case .unknown(let msg): return msg
        }
    }
    
    static func map(_ error: Error) -> AppError {
        if let _ = error as? URLError {
            return .network
        }
        if (error as NSError).code == NSUserCancelledError {
            return .cancelled
        }
        if error is DecodingError {
            return .decoding
        }
        return .unknown(error.localizedDescription)
    }
}
