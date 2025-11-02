//
//  NetworkDefinitions.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 18/10/25.
//

import Foundation

/// Abstraction over an engine capable of executing API endpoints.
protocol NetworkEngine: Sendable {
    func execute<T: Decodable, E: APIEndpoint>(_ endpoint: E) async throws -> T
}

/// HTTP methods used for API requests.
enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

/// Represents a part of a multipart request.
struct MultipartPart {
    let name: String
    let data: Data
    let filename: String?
    let mimeType: String

    init(name: String, data: Data, filename: String? = nil, mimeType: String) {
        self.name = name
        self.data = data
        self.filename = filename
        self.mimeType = mimeType
    }
}

/// Represents the body of a network request, which can be encodable data, raw data, or multipart data.
enum RequestBody {
    case encodable(Encodable)
    case data(Data)
    case multipart(boundary: String, parts: [MultipartPart])
}
