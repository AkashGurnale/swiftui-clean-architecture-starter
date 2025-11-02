//
//  UsersListView.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 16/10/25.
//

import SwiftUI

/// List screen displaying users. Reads `state` from `UsersListViewModel` and
/// renders appropriate UI for each state. Pull-to-refresh and navigation to
/// details are provided.
struct UsersListView: View {
    
    @StateObject private var viewModel: UsersListViewModel
    
    init(viewmodel: UsersListViewModel) {
        _viewModel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Fetching Users")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemBackground))
                case .failure(let errorMessage):
                    VStack(spacing: 12) {
                        Text("Something went wrong")
                            .font(.headline)
                        Text(errorMessage)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .empty:
                    VStack(spacing: 10) {
                        Text("No users found")
                            .font(.headline)
                        Button("Reload") {
                            viewModel.fetchUsers(forceRefresh: true)
                        }
                        .buttonStyle(.bordered)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .loaded:
                    if viewModel.usersList.isEmpty {
                        VStack(spacing: 10) {
                            Text("No users found")
                                .font(.headline)
                            Button("Reload") {
                                viewModel.fetchUsers(forceRefresh: true)
                            }
                            .buttonStyle(.bordered)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List(viewModel.usersList, id: \.id) { user in
                            // Wrap row in a navigation link to the details screen
                            NavigationLink(value: user.id ?? 0) {
                                UsersListRowView(user: user)
                            }
                        }
                        .listStyle(.insetGrouped)
                        .refreshable {
                            viewModel.fetchUsers(forceRefresh: true)
                        }
                        .navigationDestination(for: Int.self) { userId in
                            // Resolve a details view model from AppFactory
                            let detailsVM = AppFactory.shared.makeUserDetailsViewModel(userId: userId)
                            UserDetailsView(viewModel: detailsVM)
                        }
                    }
                }
            }
            .task {
                viewModel.fetchUsers()
            }
            .navigationTitle("Users")
        }
    }
}
