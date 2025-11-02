//
//  UserMapper.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import Foundation

/// Maps network DTOs to domain models used across the app.
///
/// Keeping DTO-to-domain mapping centralized helps avoid leaking
/// network decoding types (DTOs) into UI and business logic layers.
/// This enum exposes a simple `map(dto:)` function for converting
/// `UserDTO` to the app's `User` domain model.
enum UserMapper {
    static func map(dto: UserDTO) -> User {
        User(
            id: dto.id,
            name: dto.name,
            username: dto.username,
            email: dto.email,
            address: Address(
                street: dto.address.street,
                suite: dto.address.suite,
                city: dto.address.city,
                zipcode: dto.address.zipcode,
                geo: Geo(lat: dto.address.geo.lat, lng: dto.address.geo.lng)
            ),
            phone: dto.phone,
            website: dto.website,
            company: Company(name: dto.company.name, catchPhrase: dto.company.catchPhrase, bs: dto.company.bs)
        )
    }
}
