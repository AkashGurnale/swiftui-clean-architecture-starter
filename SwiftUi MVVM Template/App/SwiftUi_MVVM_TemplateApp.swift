//
//  SwiftUi_MVVM_TemplateApp.swift
//  SwiftUi MVVM Template
//
//  Created by Akash Gurnale on 16/10/25.
//

import SwiftUI

/// Main application entry point. SwiftUI launches the `ContentView` inside
/// a `WindowGroup`. Keep this file minimal as composition and dependency
/// resolution are delegated to `AppFactory` and child views.
@main
struct SwiftUi_MVVM_TemplateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
