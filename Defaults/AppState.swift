import SwiftUI
import AppKit
import Combine

/// Shared, app-wide state: administrator rights and the account type of the
/// current user.
///
/// Authorisation works by caching a `sudo` timestamp: the user types their
/// password once, and the app keeps the cached credentials alive so "Apply &
/// Restart" never prompts again while the app is running.
@MainActor
final class AppState: ObservableObject {
    @Published var authGranted = false
    @Published var isAdminAccount = false
    /// Drives the in-app administrator password sheet.
    @Published var showAuthSheet = false

    private var keepAliveTimer: Timer?

    init() {
        refreshPermissions()
    }

    func refreshPermissions() {
        isAdminAccount = Permissions.isAdminAccount
    }

    /// Shows the password sheet when authorisation is still needed.
    func requestAuth() {
        guard !authGranted else { return }
        showAuthSheet = true
    }

    // MARK: - Authorization

    enum AuthError: LocalizedError {
        case notAdmin
        case wrongPassword
        case failed(String)

        var errorDescription: String? {
            switch self {
            case .notAdmin:
                return "This user account is not an administrator, so it can't be authorized."
            case .wrongPassword:
                return "Incorrect password. Please try again."
            case .failed(let message):
                return message
            }
        }
    }

    /// Validates the password with `sudo` and caches the credential. After this
    /// succeeds, privileged commands run without prompting again.
    func authorize(password: String) throws {
        guard isAdminAccount else { throw AuthError.notAdmin }

        let result = runSudo(["-S", "-p", "", "-v"], password: password)
        guard result.status == 0 else {
            let message = result.stderr
            if message.contains("incorrect password")
                || message.contains("Sorry, try again")
                || message.contains("no password was provided") {
                throw AuthError.wrongPassword
            }
            throw AuthError.failed(message.isEmpty ? "Authorization failed." : message)
        }

        authGranted = true
        showAuthSheet = false
        refreshPermissions()
        startKeepAlive()
    }

    /// Invalidates the cached credential.
    func deauthorize() {
        stopKeepAlive()
        _ = runSudo(["-k"], password: nil)
        authGranted = false
    }

    /// Refreshes the sudo timestamp every minute so it never expires while the
    /// app is running.
    private func startKeepAlive() {
        stopKeepAlive()
        keepAliveTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self, self.authGranted else { return }
                if self.runSudo(["-n", "-v"], password: nil).status != 0 {
                    self.authGranted = false
                    self.stopKeepAlive()
                }
            }
        }
    }

    private func stopKeepAlive() {
        keepAliveTimer?.invalidate()
        keepAliveTimer = nil
    }

    // MARK: - Privileged execution

    enum PrivilegedResult {
        case success
        case needsAuthorization
        case failure(String)
    }

    /// Runs a shell command as root using the cached credential, so it never
    /// prompts for a password as long as the user has authorized.
    func runPrivileged(_ shellCommand: String) -> PrivilegedResult {
        guard authGranted else { return .needsAuthorization }

        let result = runSudo(["-n", "/bin/sh", "-c", shellCommand], password: nil)
        if result.status == 0 { return .success }

        let message = result.stderr
        if message.contains("a password is required") || message.contains("no tty present") {
            authGranted = false
            stopKeepAlive()
            return .needsAuthorization
        }
        return .failure(message.isEmpty ? "Command failed (status \(result.status))." : message)
    }

    // MARK: - Process helper

    private struct SudoResult {
        var status: Int32
        var stderr: String
    }

    private func runSudo(_ arguments: [String], password: String?) -> SudoResult {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/sudo")
        process.arguments = arguments

        let outPipe = Pipe()
        let errPipe = Pipe()
        process.standardOutput = outPipe
        process.standardError = errPipe

        var inputPipe: Pipe?
        if password != nil {
            let pipe = Pipe()
            process.standardInput = pipe
            inputPipe = pipe
        }

        do {
            try process.run()
        } catch {
            return SudoResult(status: -1, stderr: error.localizedDescription)
        }

        if let password, let pipe = inputPipe {
            pipe.fileHandleForWriting.write(Data((password + "\n").utf8))
            try? pipe.fileHandleForWriting.close()
        }

        let outData = outPipe.fileHandleForReading.readDataToEndOfFile()
        let errData = errPipe.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()

        _ = outData
        return SudoResult(status: process.terminationStatus,
                          stderr: String(data: errData, encoding: .utf8) ?? "")
    }
}

/// Appearance options for the app window.
enum AppTheme: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
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
}