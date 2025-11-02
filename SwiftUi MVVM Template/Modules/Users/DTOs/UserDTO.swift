//
//  UserDTO.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import Foundation

// DTOs mirror the JSON structure returned by the API. Keep them separate from domain models
// to avoid leaking network decoding concerns into the rest of the app.

/// Data Transfer Object representing a user as returned by the remote API.
///
/// This structure matches the JSON from `jsonplaceholder.typicode.com/users`.
/// Keep this separate from `User` domain models so the app can evolve without
/// direct coupling to the API contract.
struct UserDTO: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressDTO
    let phone: String
    let website: String

    let company: CompanyDTO

    struct AddressDTO: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: GeoDTO

        struct GeoDTO: Codable {
            let lat: String
            let lng: String
        }
    }

    struct CompanyDTO: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
