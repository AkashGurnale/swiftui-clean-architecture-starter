//
//  User.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 16/10/25.
//

import Foundation

// MARK: - User
/// Domain model representing a user in the app.
///
/// These types are intentionally `Decodable` to simplify testing and
/// interoperability with DTOs, but they represent the app's internal
/// shapes and may differ from network DTOs.
struct User: Decodable, Sendable, Equatable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
}

// MARK: - Address
/// Lightweight address model used by `User`.
struct Address: Decodable, Sendable, Equatable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

// MARK: - Geo
/// Geographic coordinates as strings (keeps the template simple).
struct Geo: Decodable, Sendable, Equatable {
    let lat: String?
    let lng: String?
}

// MARK: - Company
/// Company information included in the user payload.
struct Company: Decodable, Sendable, Equatable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}
