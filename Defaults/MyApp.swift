import SwiftUI

@main struct MyApp: App {
    @StateObject private var appState = AppState()
    @AppStorage("appTheme") private var appTheme: AppTheme = .system

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