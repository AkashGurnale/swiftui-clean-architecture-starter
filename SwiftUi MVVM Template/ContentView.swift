//
//  ContentView.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 16/10/25.
//

import SwiftUI

/// Root content view used by the app's window group.
///
/// This view is intentionally lightweight: it resolves the concrete
/// `UsersListViewModel` from the `AppFactory` and injects it into
/// `UsersListView`. Keeping dependency resolution centralized in
/// `AppFactory` makes the UI code easier to test and swap.
struct ContentView: View {
    var body: some View {
        // Resolve the view model using the app-level factory so views remain
        // declarative and free of wiring logic.
        let viewModel = AppFactory.shared.makeUsersListViewModel()
        UsersListView(viewmodel: viewModel)
    }
}
