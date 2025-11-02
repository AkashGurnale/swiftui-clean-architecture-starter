//
//  UserDetailsRepository.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import Foundation

protocol UserDetailsRepository {
    /// Fetch full details for a single user by id.
    /// - Parameter userId: The id of the user to fetch.
    /// - Returns: A `User` domain model with detailed fields.
    func fetchUserDetails(userId: Int) async throws -> User
}

final class UserDetailsRepositoryImpl: UserDetailsRepository {
    private let network: NetworkEngine
    private let local: LocalDataSource

    init(network: NetworkEngine, local: LocalDataSource) {
        self.network = network
        self.local = local
    }

    /// Fetch a single user's details from the network and map to domain model.
    func fetchUserDetails(userId: Int) async throws -> User {
        // Future: consider local cache for user details
        let dto: UserDTO = try await network.execute(UsersEndpoint.userDetails(userId))
        return UserMapper.map(dto: dto)
    }
}
