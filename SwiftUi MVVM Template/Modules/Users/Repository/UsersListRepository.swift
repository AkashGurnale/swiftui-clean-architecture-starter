//
//  UsersListRepository.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 21/10/25.
//

protocol UsersListRepository {
    /// Fetch users list.
    ///
    /// - Parameter forceRefresh: When true forces a network request and
    ///   bypasses any available local cache.
    /// - Returns: Array of `User` domain models.
    /// - Throws: Network or decoding related errors.
    func fetchUsersList(forceRefresh: Bool) async throws -> [User]
}

final class UsersListRepositoryImpl: UsersListRepository {
    
    private let network: NetworkEngine
    private let local: LocalDataSource
    
    init(network: NetworkEngine, local: LocalDataSource) {
        self.network = network
        self.local = local
    }
    
    /// Fetch users. Uses local cache unless `forceRefresh` is true. Network responses are decoded into DTOs
    /// and mapped to domain `User` via `UserMapper`. Cached DTOs are persisted to the local data source.
    func fetchUsersList(forceRefresh: Bool) async throws -> [User] {
        // Prefer cached DTOs stored locally
        if !forceRefresh {
            if let localUsersDTOs = try? local.load("localUsersList", as: [UserDTO].self) {
                return localUsersDTOs.map { UserMapper.map(dto: $0) }
            }
            // Backwards compatible fallback to domain objects
            if let localUsersList = try? local.load("localUsersList", as: [User].self) {
                return localUsersList
            }
        }
        
        // Fetch DTOs from network and map to domain models
        let remoteUsersDTOs: [UserDTO] = try await network.execute(UsersEndpoint.usersList)

        // Persist DTOs locally for caching (best-effort)
        do {
            try local.save("localUsersList", object: remoteUsersDTOs)
        } catch {
            #if DEBUG
            print("Warning: failed to save users DTO cache: \(error)")
            #endif
        }

        let users: [User] = remoteUsersDTOs.map { UserMapper.map(dto: $0) }
        return users
    }
    
}
