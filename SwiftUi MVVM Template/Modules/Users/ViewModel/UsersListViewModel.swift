//
//  UsersListViewModel.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import Foundation
import Combine

/// The `UsersListViewModel` class is an `ObservableObject` that manages the state and actions
/// for the users list screen. It fetches data from the `UsersListRepository` and updates its
/// state to reflect loading, loaded, empty, or error conditions.
@MainActor
final class UsersListViewModel: ObservableObject {
    
    /// Represents the current UI state for the list screen
    @Published private(set) var state: ViewState<[User]> = .idle
    
    private let repository: UsersListRepository
    
    /// Keep a reference to the active task so we can cancel it when a new request comes in
    private var currentTask: Task<Void, Never>?
    
    /// Initializes the view model with a repository.
    /// - Parameter repository: The repository to fetch the users list.
    init(repository: UsersListRepository) {
        self.repository = repository
    }
    
    /// Convenience accessor used by the view to read user values
    var usersList: [User] { state.value ?? [] }
    
    /// Public API to start fetching users. This will cancel any in-flight request
    /// - Parameter forceRefresh: A Boolean value indicating whether to force a refresh of the user list.
    func fetchUsers(forceRefresh: Bool = false) {
        // Cancel previous task if running
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.loadUsers(forceRefresh: forceRefresh)
        }
    }
    
    /// Internal async loader that updates `state`. Honors cancellation.
    /// - Parameter forceRefresh: A Boolean value indicating whether to force a refresh of the user list.
    func loadUsers(forceRefresh: Bool = false) async {
        state = .loading
        do {
            let fetchedUsers: [User] = try await repository.fetchUsersList(forceRefresh: forceRefresh)
            // If the task was cancelled while awaiting the network, bail out gracefully.
            if Task.isCancelled { return }
            if fetchedUsers.isEmpty {
                state = .empty
            } else {
                state = .loaded(fetchedUsers)
            }
        } catch {
            // Map low-level errors to AppError for a user-friendly message
            let appError = AppError.map(error)
            state = .failure(appError.message)
        }
    }
    
    deinit {
        currentTask?.cancel()
    }
}
