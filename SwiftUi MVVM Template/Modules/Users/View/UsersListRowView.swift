//
//  UsersListRowView.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

import SwiftUI


/// View representing a single row in the users list. Handles optional
/// user fields gracefully by showing sensible fallbacks.
///
/// Keep rows dumb: they only render the passed `User` model and don't
/// perform any side-effects. Navigation and actions are handled at the
/// list level.
struct UsersListRowView: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(user.name ?? "Unnamed User")
                .font(.headline)
            if let email = user.email {
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let company = user.company?.name {
                Text(company)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 6)
    }
}
