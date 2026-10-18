import SwiftUI
import AppKit

/// The app's Settings window, opened from the menu-bar item, the app menu,
/// or with ⌘,.
struct SettingsView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem { Label("General", systemImage: "gearshape") }
            PermissionsSettingsView()
                .tabItem { Label("Permissions", systemImage: "lock.shield") }
            AboutSettingsView()
                .tabItem { Label("About", systemImage: "info.circle") }
        }
        .environmentObject(appState)
        .frame(width: 480, height: 360)
    }
}

// MARK: - General

struct GeneralSettingsView: View {
    @AppStorage("showMenuBarIcon") private var showMenuBarIcon = true

    var body: some View {
        Form {
            Section {
                Toggle("Show icon in the menu bar", isOn: $showMenuBarIcon)
            } header: {
                Text("Menu Bar")
            } footer: {
                Text("Adds a status-bar item with quick access to permissions, settings, and the main window.")
                    .font(.jb(10))
                    .foregroundStyle(.secondary)
            }
        }
        .formStyle(.grouped)
    }
}

// MARK: - Permissions

struct PermissionsSettingsView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Form {
            Section("Administrator") {
                statusLine(
                    title: "Administrator account",
                    detail: appState.isAdminAccount ? "This user can administer the Mac" : "This user cannot administer the Mac",
                    ok: appState.isAdminAccount
                )

                statusLine(
                    title: "Administrator access for this app",
                    detail: appState.authGranted ? "Granted" : "Not granted yet",
                    ok: appState.authGranted
                )

                if !appState.authGranted {
                    Button("Grant Administrator Access…") {
                        appState.requestAuth()
                    }
                }
            }

            Section("Full Disk Access") {
                statusLine(
                    title: "Full Disk Access",
                    detail: appState.hasFullDiskAccess ? "Granted" : "Not granted",
                    ok: appState.hasFullDiskAccess
                )

                Text("Full Disk Access is usually not required: applying defaults and restarting apps only needs administrator access. Grant it only if a command reports a permission error.")
                    .font(.jb(10))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Button("Open Full Disk Access Settings…") {
                    Permissions.openFullDiskAccessSettings()
                }
            }

            Section("Terminal") {
                statusLine(
                    title: "Run in Terminal",
                    detail: "Uses your normal user account",
                    ok: true
                )
                Text("Terminal is opened only to run a copied command. It uses your regular account, so it does not need additional rights unless you run sudo yourself.")
                    .font(.jb(10))
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Section {
                Button("Check Permissions Again") {
                    appState.refreshPermissions()
                }
            }
        }
        .formStyle(.grouped)
    }

    private func statusLine(title: String, detail: String, ok: Bool) -> some View {
        LabeledContent {
            HStack(spacing: 6) {
                Image(systemName: ok ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                    .foregroundStyle(ok ? Color.green : Color.orange)
                Text(detail)
                    .font(.jb(11))
                    .foregroundStyle(.secondary)
            }
        } label: {
            Text(title)
                .font(.jb(11))
        }
    }
}

// MARK: - About

struct AboutSettingsView: View {
    var body: some View {
        VStack(spacing: 12) {
            if let icon = NSApplication.shared.applicationIconImage {
                Image(nsImage: icon)
                    .resizable()
                    .interpolation(.high)
                    .frame(width: 72, height: 72)
            }

            Text(AppInfo.name)
                .font(.jb(16, .bold))

            Text("View & apply macOS defaults")
                .font(.jb(11))
                .foregroundStyle(.secondary)

            Text("Version \(AppInfo.version) · \(AppInfo.year)")
                .font(.jb(10))
                .foregroundStyle(.tertiary)

            Link(destination: AppInfo.repoURL) {
                Label(AppInfo.repoURL.absoluteString, systemImage: "link")
                    .font(.jb(10))
            }

            Spacer()

            Text("© \(AppInfo.year) \(AppInfo.author)")
                .font(.jb(10))
                .foregroundStyle(.tertiary)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}