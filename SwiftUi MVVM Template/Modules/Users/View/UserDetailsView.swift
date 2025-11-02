//
//  UserDetailsView.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import SwiftUI

/// View that shows detailed information about a single user.
///
/// Observes `UserDetailsViewModel.state` and renders loading, error,
/// empty, and loaded states. The view triggers `fetchUserDetails()` via
/// `.task` when it appears and provides a retry button on failure.
struct UserDetailsView: View {
    @StateObject private var viewModel: UserDetailsViewModel

    init(viewModel: UserDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView("Loading user details...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .failure(let message):
                VStack(spacing: 12) {
                    Text("Unable to load user")
                        .font(.headline)
                    Text(message)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.secondary)
                    Button("Retry") {
                        viewModel.fetchUserDetails()
                    }
                    .buttonStyle(.glass)
                }
                .padding()
            case .loaded:
                if let user = viewModel.user {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(user.name ?? "Unnamed")
                                .font(.title2)
                                .bold()

                            HStack {
                                Image(systemName: "person.fill")
                                Text(user.username ?? "-")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                            if let email = user.email {
                                HStack {
                                    Image(systemName: "envelope")
                                    Text(email)
                                }
                                .font(.subheadline)
                            }

                            if let phone = user.phone {
                                HStack {
                                    Image(systemName: "phone.fill")
                                    Text(phone)
                                }
                                .font(.subheadline)
                            }

                            if let website = user.website {
                                HStack {
                                    Image(systemName: "globe")
                                    Text(website)
                                }
                                .font(.subheadline)
                            }

                            Divider()

                            if let addr = user.address {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Address")
                                        .font(.headline)
                                    Text([addr.street, addr.suite, addr.city, addr.zipcode].compactMap { $0 }.joined(separator: ", "))
                                        .font(.subheadline)
                                }
                            }

                            if let company = user.company {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Company")
                                        .font(.headline)
                                    Text(company.name ?? "-")
                                        .font(.subheadline)
                                    if let catchPhrase = company.catchPhrase {
                                        Text(catchPhrase)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }

                            Spacer()
                        }
                        .padding()
                    }
                } else {
                    Text("No details")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            case .empty:
                Text("No details")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("Details")
        .task {
            viewModel.fetchUserDetails()
        }
    }
}
