//
//  ViewState.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 01/11/25.
//

/// Generic enum representing common UI states for a view: idle, loading, loaded,
/// empty and failure.
///
/// The generic `T` holds the loaded value when `.loaded`.
enum ViewState<T: Equatable>: Equatable {
    case idle
    case loading
    case loaded(T)
    case empty
    case failure(String)

    var value: T? {
        if case let .loaded(value) = self {
            return value
        }
        return nil
    }

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
}
