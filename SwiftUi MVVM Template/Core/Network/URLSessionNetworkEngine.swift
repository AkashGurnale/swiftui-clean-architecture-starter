//
//  URLSessionNetworkEngine.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 18/10/25.
//

import Foundation

/// Default `NetworkEngine` implementation using `URLSession` and the
/// `RequestBuilder` to perform API requests.
final class URLSessionNetworkEngine: NetworkEngine {
    
    private let builder: RequestBuilder
    private let urlSession: URLSession
    
    init(builder: RequestBuilder = RequestBuilder(),
         urlSession: URLSession = .shared) {
        self.builder = builder
        self.urlSession = urlSession
    }
    
    /// Execute the given endpoint and decode the response into the expected type `T`.
    ///
    /// Throws `NetworkError` cases when the request/response lifecycle fails or decoding fails.
    func execute<T, E>(_ endpoint: E) async throws -> T where T : Decodable, E : APIEndpoint {
        let request = try builder.buildRequest(from: endpoint)
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200...300 ~= httpResponse.statusCode else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode, message: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    
    
}
