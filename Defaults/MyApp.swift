import SwiftUI

@main struct MyApp: App {
    @StateObject private var appState = AppState()
    @AppStorage("showMenuBarIcon") private var showMenuBarIcon = true
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

        MenuBarExtra("Defaults", systemImage: "slider.horizontal.3", isInserted: $showMenuBarIcon) {
            MenuBarView()
                .environmentObject(appState)
        }

        Settings {
            SettingsView()
                .environmentObject(appState)
                .preferredColorScheme(appTheme.colorScheme)
        }
    }
}