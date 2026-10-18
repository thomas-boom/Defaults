import SwiftUI
import AppKit

/// Contents of the app's menu-bar (status bar) item.
struct MenuBarView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.openWindow) private var openWindow
    @AppStorage("showMenuBarIcon") private var showMenuBarIcon = true

    var body: some View {
        Button("Open Defaults") {
            NSApp.activate(ignoringOtherApps: true)
            openWindow(id: "main")
        }
        .keyboardShortcut("o")

        Divider()

        Text("Permissions")

        statusRow(
            title: appState.authGranted ? "Administrator access granted" : "Administrator access needed",
            ok: appState.authGranted
        )
        statusRow(
            title: appState.hasFullDiskAccess ? "Full Disk Access granted" : "Full Disk Access not granted",
            ok: appState.hasFullDiskAccess
        )

        if !appState.authGranted {
            Button("Grant Administrator Access…") {
                appState.requestAuth()
            }
        }

        Button("Check Permissions Again") {
            appState.refreshPermissions()
        }

        if !appState.hasFullDiskAccess {
            Button("Open Full Disk Access Settings…") {
                Permissions.openFullDiskAccessSettings()
            }
        }

        Divider()

        Toggle("Show Menu Bar Icon", isOn: $showMenuBarIcon)

        SettingsLink {
            Text("Settings…")
        }
        .keyboardShortcut(",")

        Divider()

        Button("Quit Defaults") {
            NSApp.terminate(nil)
        }
        .keyboardShortcut("q")
    }

    private func statusRow(title: String, ok: Bool) -> some View {
        Label {
            Text(title)
        } icon: {
            Image(systemName: ok ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
        }
    }
}