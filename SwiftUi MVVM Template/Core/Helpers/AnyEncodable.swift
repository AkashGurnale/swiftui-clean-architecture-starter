//
//  AnyEncodable.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 18/10/25.
//


/// A small type-erasing wrapper for `Encodable` values.
///
/// `RequestBuilder` uses `AnyEncodable` to encode heterogeneous
/// `Encodable` payloads without exposing concrete generic types.

struct AnyEncodable: Encodable {
    private let encodeFunc: (Encoder) throws -> Void

    init<T: Encodable>(_ wrapped: T) {
        self.encodeFunc = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try encodeFunc(encoder)
    }
}
