//
//  HTTPHeaders.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 18/10/25.
//

/// Small helper to manage HTTP header fields in a type-safe way.
///
/// Provides convenience methods for common headers and merging behavior
/// when composing requests.
struct HTTPHeaders: Sendable {
    private(set) var values: [String: String] = [:]
    
    init(_ initial: [String: String] = [:]) {
        self.values = initial
    }
    
    mutating func add(_ name: HeaderName, value: String) {
        values[name.rawValue] = value
    }
    
    mutating func setContentType(_ type: ContentType) {
        values[HeaderName.contentType.rawValue] = type.rawValue
    }
    
    func asDictionary() -> [String: String] {
        values
    }
    
    /// Merge another HTTPHeaders into this one.
    /// Values from the new headers overwrite existing ones.
    mutating func merge(_ other: HTTPHeaders) {
        for (key, value) in other.values {
            values[key] = value
        }
    }
    
    /// Create a merged copy instead of mutating.
    func merged(with other: HTTPHeaders) -> HTTPHeaders {
        var copy = self
        copy.merge(other)
        return copy
    }
}

extension HTTPHeaders {
    static var `default`: HTTPHeaders {
        HTTPHeaders([
            HeaderName.accept.rawValue: ContentType.json.rawValue,
            HeaderName.contentType.rawValue: ContentType.json.rawValue
        ])
    }
}


enum HeaderName: String {
    case contentType = "Content-Type"
    case accept = "Accept"
    case authorization = "Authorization"
}

enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
    case formUrlEncoded = "application/x-www-form-urlencoded"
}
