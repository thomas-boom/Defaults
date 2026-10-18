import SwiftUI

@main struct MyApp: App {
    @StateObject private var appState = AppState()
    @AppStorage("appTheme") private var appTheme: AppTheme = .system

    init() {
        // Must happen before any view is built, so `Font.jb` finds the bundled
        // JetBrains Mono instead of falling back to a system font.
        BundledFonts.register()
    }

    var body: some Scene {
        WindowGroup(id: "main") {
            ZStack {
                WindowBackdrop()
                ContentView()
            }
            .environmentObject(appState)
            .preferredColorScheme(appTheme.colorScheme)
        }
        .defaultSize(width: AppMetrics.defaultWindowWidth, height: AppMetrics.defaultWindowHeight)

        Settings {
            SettingsView()
                .environmentObject(appState)
                .preferredColorScheme(appTheme.colorScheme)
        }
    }
}