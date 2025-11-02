//
//  LocalDataSource.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 21/10/25.
//

import Foundation

/// Simple protocol that abstracts reading and writing JSON from/to local storage.
///
/// The default implementation reads first from the app's Documents directory
/// (for runtime cache) and falls back to bundled JSON fixtures included in the
/// app bundle. This keeps the template simple while demonstrating a basic
/// caching strategy.
protocol LocalDataSource {
    /// Load a decodable object from a JSON file in the app's local storage.
    ///
    /// - Parameters:
    ///   - filename: The name of the file (without the `.json` extension) to load the object from.
    ///   - type: The type of the object to decode.
    /// - Returns: The decoded object.
    /// - Throws: An error if the file doesn't exist, the data is invalid, or the decoding fails.
    func load<T: Decodable>(_ filename: String, as type: T.Type) throws -> T

    /// Save encodable object to a local JSON file (Documents directory). Used for simple caching.
    ///
    /// - Parameters:
    ///   - filename: The name of the file (without the `.json` extension) to save the object to.
    ///   - object: The encodable object to save.
    /// - Throws: An error if the encoding fails or the file can't be written.
    func save<T: Encodable>(_ filename: String, object: T) throws
}


final class JSONFileDataSource: LocalDataSource {
    func load<T>(_ filename: String, as type: T.Type) throws -> T where T : Decodable {
        // Prefer cached file in the app's Documents directory so runtime caching works.
        let fm = FileManager.default
        if let docs = try? fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            let fileURL = docs.appendingPathComponent("\(filename).json")
            if fm.fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: fileURL)
                return try JSONDecoder().decode(T.self, from: data)
            }
        }

        // Fallback to bundled fixtures shipped with the app (read-only)
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw NetworkError.invalidURL
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }

    func save<T>(_ filename: String, object: T) throws where T : Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(object)

        let fm = FileManager.default
        let docs = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = docs.appendingPathComponent("\(filename).json")
        try data.write(to: fileURL, options: [.atomic])
    }
}
