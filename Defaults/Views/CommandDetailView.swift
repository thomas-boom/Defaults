import SwiftUI
import AppKit

struct CommandDetailView: View {
    let command: DefaultsCommand
    let onCopy: (String) -> Void
    @EnvironmentObject private var appState: AppState
    
    @State private var selectedOptionID: UUID?
    @State private var hoveringTerminal = false
    
    private var selectedOption: DefaultsOption? {
        if let id = selectedOptionID, let option = command.options.first(where: { $0.id == id }) {
            return option
        }
        return command.options.first
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                header
                
                if let risk = command.risk {
                    riskBanner(risk)
                }
                
                infoGrid
                
                section(title: "What it does") {
                    Text(command.summary)
                        .font(.jb(12))
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                section(title: "Read Command") {
                    CodeBlockView(command: command.readCommand(), onCopy: onCopy)
                }
                
                optionsSection
                
                Text("Tip: copy a command and paste it into Terminal with ⌘V, or use the Terminal button in the lower-right corner to run it directly.")
                    .font(.jb(10))
                    .foregroundStyle(.tertiary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentMargins(.bottom, 10, for: .scrollContent)

        .onAppear {
            if selectedOptionID == nil {
                selectedOptionID = command.options.first?.id
            }
        }
    }
    
    // MARK: - Sections
    
    private var header: some View {
        HStack(alignment: .center, spacing: 10) {
            CategoryIcon(category: command.category, size: 26)
            
            VStack(alignment: .leading, spacing: 1) {
                Text(command.title)
                    .font(.jb(17, .bold))
                Text(command.category.displayName)
                    .font(.jb(10))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            typeBadge
        }
    }
    
    private var infoGrid: some View {
        Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 8) {
            GridRow {
                infoLabel("Domain")
                infoValue(command.domain)
                infoLabel("Key")
                infoValue(command.key)
            }
            GridRow {
                infoLabel("Type")
                infoValue(command.type.displayName)
                infoLabel("Default")
                infoValue(command.default ?? "—")
            }
            GridRow {
                infoLabel("Restart")
                infoValue(command.restartApplication ?? "Not required")
                infoLabel("Reload")
                infoValue(reloadRequirement)
            }
        }
        .padding(10)
        .background(.quaternary.opacity(0.4), in: RoundedRectangle(cornerRadius: 8))
    }
    
    private var reloadRequirement: String {
        if let app = command.restartApplication {
            return "Restart \(app)"
        }
        return "Applies immediately"
    }
    
    private var optionsSection: some View {
        section(title: "Adjustable Options") {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Picker("Option", selection: $selectedOptionID) {
                        ForEach(command.options) { option in
                            Text(option.label).tag(Optional(option.id))
                        }
                    }
                    .pickerStyle(.menu)
                    .font(.jb(11))
                    .frame(minWidth: 180, maxWidth: 260)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        if let option = selectedOption {
                            onCopy(command.writeCommand(for: option))
                        }
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .font(.jb(11))
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    .disabled(selectedOption == nil)
                    
                    Button(action: applyAndRestart) {
                        Label("Apply & Restart", systemImage: "play.fill")
                            .font(.jb(11))
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                    .disabled(selectedOption == nil)
                }
                
                if let option = selectedOption {
                    if let detail = option.detail {
                        Text(detail)
                            .font(.jb(10))
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    CodeBlockView(command: command.writeCommand(for: option), onCopy: onCopy)
                }
            }
        }
    }
    
    private var terminalButton: some View {
        EmptyView()
    }
    
    var terminalButtonSmall: some View {
        Button(action: openInTerminal) {
            Image(systemName: "terminal.fill")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 22, height: 22)
                .background(Color.black, in: RoundedRectangle(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(Color.white.opacity(0.18), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .scaleEffect(hoveringTerminal ? 1.08 : 1.0)
        .shadow(color: .black.opacity(hoveringTerminal ? 0.35 : 0.2),
                radius: hoveringTerminal ? 4 : 2, y: 1)
        .animation(.easeInOut(duration: 0.15), value: hoveringTerminal)
        .onHover { isHovering in
            hoveringTerminal = isHovering
        }
        .disabled(selectedOption == nil)
        .help("Run the selected command in Terminal")
    }
    
    private func riskBanner(_ message: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 13))
                .foregroundStyle(.orange)
            Text(message)
                .font(.jb(11))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.orange.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.orange.opacity(0.35))
        )
    }
    
    // MARK: - Helpers
    
    private func infoLabel(_ text: String) -> some View {
        Text(text)
            .font(.jb(10))
            .foregroundStyle(.secondary)
    }
    
    private func infoValue(_ text: String) -> some View {
        Text(text)
            .font(.jb(10))
            .textSelection(.enabled)
    }
    
    private var typeBadge: some View {
        Text(command.type.displayName)
            .font(.jb(9, .medium))
            .padding(.horizontal, 7)
            .padding(.vertical, 2)
            .background(typeColor.opacity(0.15), in: Capsule())
            .foregroundStyle(typeColor)
    }
    
    private var typeColor: Color {
        switch command.type {
        case .bool:
            return .blue
        case .int, .float:
            return .purple
        case .string, .enumType:
            return .green
        case .array:
            return .orange
        }
    }
    
    @ViewBuilder
    private func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.jb(12, .semibold))
            content()
        }
    }
    
    // MARK: - Actions
    
    private func restartCommands(for target: String) -> [String] {
        let target = target.lowercased()
        var commands: [String] = []
        if target.contains("dock") { commands.append("killall Dock") }
        if target.contains("finder") { commands.append("killall Finder") }
        if target.contains("safari") { commands.append("killall Safari") }
        if target.contains("mail") { commands.append("killall Mail") }
        if target.contains("terminal") { commands.append("killall Terminal") }
        if target.contains("textedit") { commands.append("killall TextEdit") }
        if target.contains("xcode") { commands.append("killall Xcode") }
        if target.contains("activity monitor") { commands.append("killall \"Activity Monitor\"") }
        if target.contains("simulator") { commands.append("killall Simulator") }
        if target.contains("messages") { commands.append("killall Messages") }
        if target.contains("music") { commands.append("killall Music") }
        if target.contains("disk utility") || target.contains("diskutility") {
            commands.append("killall \"Disk Utility\" 2>/dev/null || killall DiskUtility 2>/dev/null")
        }
        return commands
    }
    
    private func applyAndRestart() {
        guard let option = selectedOption else { return }
        let writeCmd = command.writeCommand(for: option)
        onCopy(writeCmd)
        
        var commands = [writeCmd]
        if let target = command.restartApplication {
            commands.append(contentsOf: restartCommands(for: target))
        }
        let shellCmd = commands.joined(separator: "; ")
        let target = (command.restartApplication ?? "").lowercased()
        
        switch appState.runPrivileged(shellCmd) {
        case .needsAuthorization:
            appState.requestAuth()
            presentAlert(
                title: "Authorization Required",
                message: "Please authorize first, then press Apply & Restart again.\n\nThe command was copied to the clipboard:\n\(writeCmd)",
                style: .warning
            )
        case .failure(let message):
            presentAlert(
                title: "Failed to apply change",
                message: "\(message)\n\nThe command was copied to the clipboard:\n\(writeCmd)",
                style: .warning
            )
        case .success:
            if target.contains("log out") {
                presentAlert(
                    title: "Applied",
                    message: "Executed with elevated privileges:\n\(writeCmd)\n\nThis change requires logging out and back in to take full effect.",
                    style: .informational
                )
            } else if target.contains("relaunch apps") {
                presentAlert(
                    title: "Applied",
                    message: "Executed with elevated privileges:\n\(writeCmd)\n\nYou may need to relaunch affected apps for the change to take effect.",
                    style: .informational
                )
            } else if commands.count > 1 {
                presentAlert(
                    title: "Applied & Restarted",
                    message: "Executed with elevated privileges:\n\(shellCmd)",
                    style: .informational
                )
            } else {
                presentAlert(
                    title: "Applied",
                    message: "Executed with elevated privileges:\n\(writeCmd)",
                    style: .informational
                )
            }
        }
    }
    
    private func openInTerminal() {
        guard let option = selectedOption else { return }
        let cmd = command.writeCommand(for: option)
        onCopy(cmd)
        
        let escaped = cmd
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
        let script = """
        tell application "Terminal"
            activate
            do script "\(escaped)"
        end tell
        """
        var error: NSDictionary?
        NSAppleScript(source: script)?.executeAndReturnError(&error)
        
        if let error = error {
            let msg = error[NSAppleScript.errorMessage] as? String ?? "Unknown error"
            NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Applications/Utilities/Terminal.app"))
            presentAlert(
                title: "Opened Terminal",
                message: "Could not run the command automatically (\(msg)).\n\nThe command was copied to the clipboard — paste it with ⌘V.",
                style: .warning
            )
        }
    }
    
    private func presentAlert(title: String, message: String, style: NSAlert.Style) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = style
        alert.runModal()
    }
}

struct CodeBlockView: View {
    let command: String
    let onCopy: (String) -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            Text(command)
                .font(.jb(11))
                .lineLimit(1)
                .truncationMode(.middle)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                onCopy(command)
            }) {
                Image(systemName: "doc.on.doc")
                    .font(.system(size: 11))
            }
            .buttonStyle(.borderless)
            .help("Copy to clipboard (then paste in Terminal with ⌘V)")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(.background, in: RoundedRectangle(cornerRadius: 6))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .strokeBorder(.separator.opacity(0.4))
        )
    }
}