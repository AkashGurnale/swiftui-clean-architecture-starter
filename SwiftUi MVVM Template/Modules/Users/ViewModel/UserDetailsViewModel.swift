//
//  UserDetailsViewModel.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import Foundation
import Combine

/// View model responsible for loading and exposing a single user's details.
///
/// It exposes a `state` that the view observes to update the UI and manages
/// cancellation of in-flight requests when the view disappears or a new fetch
/// is triggered.
@MainActor
final class UserDetailsViewModel: ObservableObject {
    
    @Published private(set) var state: ViewState<User> = .idle
    private let repository: UserDetailsRepository
    private var currentTask: Task<Void, Never>?
    private let userId: Int

    init(userId: Int, repository: UserDetailsRepository) {
        self.userId = userId
        self.repository = repository
    }

    var user: User? { state.value }

    /// Start fetching user details. Cancels any previous in-flight request.
    func fetchUserDetails() {
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            await self?.loadUserDetails()
        }
    }

    /// Internal loader that updates `state`. Handles errors and maps them to user-friendly messages.
    func loadUserDetails() async {
        state = .loading
        do {
            let user = try await repository.fetchUserDetails(userId: userId)
            if Task.isCancelled { return }
            state = .loaded(user)
        } catch {
            // Map low-level errors to AppError for consistent UI messaging
            let appError = AppError.map(error)
            state = .failure(appError.message)
        }
    }

    deinit {
        currentTask?.cancel()
    }
}
