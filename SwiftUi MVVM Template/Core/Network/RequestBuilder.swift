//
//  RequestBuilder.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 17/10/25.
//

import Foundation

/// Helper that converts an `APIEndpoint` description into a configured `URLRequest`.
///
/// Responsibilities:
/// - Compose base URL, path and query items via `URLComponents`.
/// - Apply headers (merging defaults with endpoint specific headers).
/// - Encode request bodies (JSON, raw data, multipart) and set content-type when needed.
struct RequestBuilder {
    
    private let defaultHeaders: HTTPHeaders = {
        var headers = HTTPHeaders()
        headers.setContentType(.json)
        headers.add(.accept, value: ContentType.json.rawValue)
        return headers
    }()
    
    func buildRequest<T: APIEndpoint>(from endpoint: T) throws -> URLRequest {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.method.rawValue

        var headers = defaultHeaders
        if let endpointHeaders = endpoint.headers {
            headers.merge(endpointHeaders)
        }
        
        if case .multipart(let boundary, _) = endpoint.body {
            headers.add(.contentType, value: "\(ContentType.multipart.rawValue); boundary=\(boundary)")
        }
        
        for (key, value) in headers.asDictionary() {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = endpoint.body {
            switch body {
            case .encodable(let model):
                request.httpBody = try JSONEncoder().encode(AnyEncodable(model))
            case .data(let data):
                request.httpBody = data
            case .multipart(let boundary, let parts):
                request.httpBody = try createMultipartBody(parts: parts, boundary: boundary)
            }
        }
        return request
    }
    
    private func createMultipartBody(parts: [MultipartPart], boundary: String) throws -> Data {
        var body = Data()
        
        for part in parts {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(part.name)\"".data(using: .utf8)!)
            
            if let filename = part.filename {
                body.append("; filename=\"\(filename)\"".data(using: .utf8)!)
            }
            
            body.append("\r\nContent-Type: \(part.mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(part.data)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
    
}
