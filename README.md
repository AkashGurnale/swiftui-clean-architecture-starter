# SwiftUI MVVM Template


SwiftUI · MVVM · Repository Pattern · Combine · Async/Await · Clean Architecture

A minimal, opinionated Swift + SwiftUI starter template demonstrating a clean MVVM architecture with async/await, a layered networking stack, DTO-to-domain mapping, and simple local caching.

This repository is intended as a starter for developers and founders who want a small, well-documented project they can fork and extend. It is also suited for publishing articles showing modern Swift architecture and best practices.

---

## Highlights

- Clean separation of concerns: View -> ViewModel -> Repository -> Network/Data
- Protocol-driven components for easy testing and swapping (e.g., `NetworkEngine`, repository protocols)
- Modern concurrency with async/await and controlled Task cancellation in view models
- DTOs and mappers to isolate network contracts from domain models
- Simple local JSON file caching (Documents directory + bundled fixtures)
- Small, focused files and clear composition via an `AppFactory`

---

## Quickstart

1. Open the Xcode project: `SwiftUi MVVM Template.xcodeproj`.
2. Select a simulator or a device and run.
3. The app fetches a list of users from `jsonplaceholder.typicode.com` and demonstrates navigation to a details screen.

Notes:
- The base API is configured at `Core/Endpoints/APIEndpoint.swift` (constant `APIConstants.baseURL`).
- Local fixtures are read from the app bundle when no cached copy exists.

---

## Project structure (high-level)

- App/
  - `AppFactory.swift` — Central dependency composition (repositories, view models).
  - `SwiftUi_MVVM_TemplateApp.swift` — App entry point.

- Core/
  - Endpoints/
    - `APIEndpoint.swift` — Endpoint protocol + base URL.
    - `UsersEndpoint.swift` — Users-related endpoints used by the sample feature.
  - Network/
    - `NetworkDefinitions.swift` — `NetworkEngine` protocol, `RequestBody` enum, `MultipartPart`.
    - `RequestBuilder.swift` — Builds `URLRequest` from an `APIEndpoint`.
    - `URLSessionNetworkEngine.swift` — Concrete `NetworkEngine` using `URLSession`.
    - `HTTPHeaders.swift` — Helper for header management.
    - `NetworkError.swift` / `AppError.swift` — Low-level and UI-friendly error types.
  - Helpers/
    - `AnyEncodable.swift` — Small type-erasing wrapper for encoding heterogeneous `Encodable` values.
  - Persistence/
    - `LocalDataSource.swift` — Simple file-based JSON cache implementation.

- Shared/
  - UI/
    - `ViewState.swift` — Generic UI state enum used across view models.

- Users/ (feature)
  - DTOs/
    - `UserDTO.swift` — Network DTO matching the JSON payload.
  - Mappers/
    - `UserMapper.swift` — Converts `UserDTO` -> `User` domain model.
  - Model/
    - `User.swift` — Domain model used throughout the app.
  - Repository/
    - `UsersListRepository.swift` — Protocol + implementation (cache + network).
    - `UserDetailsRepository.swift` — Protocol + implementation for single user details.
  - ViewModel/
    - `UsersListViewModel.swift` — Manages users-list state and refresh.
    - `UserDetailsViewModel.swift` — Manages detail screen state.
  - View/
    - `UsersListView.swift`, `UsersListRowView.swift`, `UserDetailsView.swift` — SwiftUI views.

---

## Key classes and how they work

- `AppFactory`
  - Single place to compose and provide dependencies. Use this for production wiring and tests (swap implementations).

- `NetworkEngine` & `RequestBuilder`
  - `RequestBuilder` turns an `APIEndpoint` into a `URLRequest` (query items, headers, body encoding).
  - `URLSessionNetworkEngine` performs the HTTP request and decodes the response.

- `LocalDataSource` (`JSONFileDataSource`)
  - Provides a tiny caching layer: read from Documents directory first, else from bundled fixtures. Also persists DTOs for offline testing.

- `ViewState<T>`
  - Single source of truth for view UI state (idle, loading, loaded, empty, failure).

- ViewModels
  - Annotated `@MainActor` and expose `@Published var state: ViewState<T>`.
  - Keep a `Task` reference to support cancellation before starting a new fetch.

---

## How to extend

Add a new feature (example: Posts):

1. Create `Posts/DTOs`, `Posts/Model`, `Posts/Mappers`, `Posts/Repository`, `Posts/ViewModel`, `Posts/View`.
2. Add endpoints in `Core/Endpoints` (e.g. `PostsEndpoint`).
3. Implement repository conforming to protocol and composed in `AppFactory`.
4. Create a view model annotated with `@MainActor` and using `ViewState<T>`.
5. Add UI views and wire navigation via `AppFactory`.

Testing:
- Make a test implementation of `NetworkEngine` that returns fixtures. Inject it by creating a test-scoped `AppFactory` or constructor injection into the repository.

---

## Future Scope

I plan on extending this template to support caching and local storage support as well as testing. Might take a little time since I'm usually slammed with work, but I will definitely add more to this project. 

## Note

If you guys need any help with implementing this project or running your first app or making complex, production grade implementations - do not hesitate to reach out to me, I'm on linkedIn - Akash Gurnale. I'll be happy to help!
