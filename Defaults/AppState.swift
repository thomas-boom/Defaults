import SwiftUI
import AppKit
import Combine

/// Shared, app-wide state: administrator rights, Full Disk Access status and
/// the account type of the current user. Both the main window and the menu-bar
/// extra read from this single source of truth.
@MainActor
final class AppState: ObservableObject {
    @Published var authGranted = false
    @Published var hasFullDiskAccess = false
    @Published var isAdminAccount = false
    
    init() {
        refreshPermissions()
    }
    
    func refreshPermissions() {
        isAdminAccount = Permissions.isAdminAccount
        hasFullDiskAccess = Permissions.hasFullDiskAccess
    }
    
    /// Triggers the native macOS administrator authentication dialog.
    /// The user types their username and password; on success the app holds
    /// elevated rights for the session and `authGranted` becomes true.
    func requestAuth() {
        let script = "do shell script \"true\" with administrator privileges"
        var error: NSDictionary?
        NSAppleScript(source: script)?.executeAndReturnError(&error)
        authGranted = (error == nil)
    }
}

/// Helpers for detecting the privileges the app may need.
enum Permissions {
    /// Whether the current user is a member of the `admin` group.
    static var isAdminAccount: Bool {
        guard let adminGroup = getgrnam("admin") else { return false }
        let adminGID = adminGroup.pointee.gr_gid

        let name = NSUserName()
        let primaryGID = Int32(getgid())
        var groups = [Int32](repeating: 0, count: 32)
        var count = Int32(groups.count)
        if getgrouplist(name, primaryGID, &groups, &count) == -1 {
            groups = [Int32](repeating: 0, count: Int(count))
            guard getgrouplist(name, primaryGID, &groups, &count) != -1 else { return false }
        }
        return groups.prefix(Int(count)).map { gid_t($0) }.contains(adminGID)
    }

    /// Best-effort Full Disk Access detection by probing files that are
    /// protected by TCC. Returns false when none of the probes are readable.
    static var hasFullDiskAccess: Bool {
        let home = FileManager.default.homeDirectoryForCurrentUser
        let probes = [
            "Library/Application Support/com.apple.TCC/TCC.db",
            "Library/Safari/History.db",
            "Library/Messages/chat.db"
        ]

        for relative in probes {
            let path = home.appendingPathComponent(relative).path
            guard FileManager.default.fileExists(atPath: path) else { continue }
            if let handle = FileHandle(forReadingAtPath: path) {
                try? handle.close()
                return true
            }
            return false
        }

        // Fallback: reading the TCC directory itself is also gated by TCC.
        let directory = home.appendingPathComponent("Library/Application Support/com.apple.TCC").path
        if FileManager.default.fileExists(atPath: directory) {
            return (try? FileManager.default.contentsOfDirectory(atPath: directory)) != nil
        }
        return false
    }

    /// Opens System Settings → Privacy & Security → Full Disk Access.
    static func openFullDiskAccessSettings() {
        let candidates = [
            "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles",
            "x-apple.systempreferences:com.apple.settings.PrivacySecurity.extension?Privacy_AllFiles"
        ]
        for string in candidates {
            if let url = URL(string: string), NSWorkspace.shared.open(url) {
                return
            }
        }
        NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Applications/System Settings.app"))
    }
}