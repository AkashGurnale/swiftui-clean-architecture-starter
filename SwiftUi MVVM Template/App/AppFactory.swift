//
//  AppFactory.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import Foundation

/// Centralized factory responsible for composing app dependencies.
///
/// Use this to resolve repositories, view models and other app-scoped singletons
/// Keeping composition in one place simplifies testing
/// (you can replace the factory or its components in unit tests) and
/// keeps view code free of wiring logic.
final class AppFactory {
    static let shared = AppFactory()
    private init() {}

    // MARK: - Core Dependencies
    /// Network engine used by repository implementations. The concrete
    /// type is `URLSessionNetworkEngine`, but tests can inject a mock
    /// by using a different factory in test targets.
    private lazy var networkEngine: NetworkEngine = URLSessionNetworkEngine()

    /// Local data source used for simple file-based caching. Default
    /// implementation reads from bundled fixtures and writes to
    /// the app's Documents directory.
    private lazy var localDataSource: LocalDataSource = JSONFileDataSource()

    // MARK: - Repository
    /// Creates and returns the concrete `UsersListRepository` used by
    /// the list screen view model.
    func makeUsersRepository() -> UsersListRepository {
        UsersListRepositoryImpl(network: networkEngine, local: localDataSource)
    }

    // MARK: - ViewModels
    /// Returns a freshly constructed `UsersListViewModel` wired with
    /// the appropriate repository.
    func makeUsersListViewModel() -> UsersListViewModel {
        UsersListViewModel(repository: makeUsersRepository())
    }

    // MARK: - User Details wiring
    /// Returns a repository implementation for fetching a single user's details.
    func makeUserDetailsRepository() -> UserDetailsRepository {
        UserDetailsRepositoryImpl(network: networkEngine, local: localDataSource)
    }

    /// Creates a `UserDetailsViewModel` for the provided `userId`.
    func makeUserDetailsViewModel(userId: Int) -> UserDetailsViewModel {
        UserDetailsViewModel(userId: userId, repository: makeUserDetailsRepository())
    }
}
