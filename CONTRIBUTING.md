Thank you for considering contributing to the SwiftUI MVVM Template project!

This document describes a few simple guidelines to make contributions easy to review and merge.

Getting started
---------------
- Fork the repository and create a feature branch from `main`:

```bash
# clone your fork
git clone git@github.com:<your-username>/swiftui-clean-architecture-starter.git
cd swiftui-mvvm-template
# create a branch for your work
git checkout -b feat/your-feature
```

- Make small, focused changes with descriptive commit messages.

Coding style
------------
- Follow idiomatic Swift and SwiftUI conventions.
- Prefer small files and single responsibility.
- Use `@MainActor` for view-models or UI-updating async methods.
- Keep public APIs small and protocol-driven for testability.

Formatting & linting
--------------------
- Run `swiftformat` or `swift-format` if available in your environment.
- Add/observe `.swiftlint.yml` rules if the project has them (not included by default).

Testing
-------
- Add unit tests for new logic and aim for deterministic tests.
- If you introduce network calls, provide a `NetworkEngine` mock for tests and inject it into repositories/view models.

Pull requests
-------------
- Open a PR against `main` in the upstream repository.
- Include a short description of the change and why it's needed.
- Link any related issue if available.
- Keep PRs small and focused. Large feature PRs are harder to review.

Review process
--------------
- PRs will be reviewed for correctness, readability, and test coverage.
- Address requested changes with further commits.

Security & sensitive data
-------------------------
- Do not commit secrets, API keys, or personal data. Use environment variables or secrets management for CI.

License
-------
- This project is released under the MIT License. By contributing you agree that your contributions will be licensed under the MIT License.

Thank you for improving the project! If you want help implementing your first contribution, add a note to the issue or open a draft PR and ask for feedback.
