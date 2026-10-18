import SwiftUI

/// In-app administrator password prompt. The password is used once to cache a
/// `sudo` credential; it is never stored.
struct AuthSheet: View {
    @EnvironmentObject private var appState: AppState
    @State private var password = ""
    @State private var errorMessage: String?
    @FocusState private var passwordFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "lock.shield.fill")
                    .foregroundStyle(.red)
                Text("Administrator Access")
                    .font(.jb(14, .semibold))
            }

            Text("Enter your administrator password once. It is only used to grant permission, and the app reuses it so you won't be asked on every change.")
                .font(.jb(10))
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .font(.jb(12))
                .focused($passwordFocused)
                .onSubmit(submit)

            if let errorMessage {
                Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                    .font(.jb(10))
                    .foregroundStyle(.red)
                    .fixedSize(horizontal: false, vertical: true)
            }

            HStack {
                Spacer()
                Button("Cancel") {
                    appState.showAuthSheet = false
                }
                .keyboardShortcut(.cancelAction)

                Button("Authorize", action: submit)
                    .keyboardShortcut(.defaultAction)
                    .disabled(password.isEmpty)
            }
        }
        .padding(18)
        .frame(width: 380)
        .onAppear { passwordFocused = true }
    }

    private func submit() {
        guard !password.isEmpty else { return }
        errorMessage = nil
        do {
            try appState.authorize(password: password)
            password = ""
        } catch {
            errorMessage = error.localizedDescription
            password = ""
            passwordFocused = true
        }
    }
}