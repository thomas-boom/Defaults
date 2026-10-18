import SwiftUI
import AppKit

struct CommandDetailView: View {
    let command: DefaultsCommand
    @Binding var authGranted: Bool
    let onCopy: (String) -> Void
    
    @State private var selectedOptionID: UUID?
    
    private var selectedOption: DefaultsOption? {
        if let id = selectedOptionID, let option = command.options.first(where: { $0.id == id }) {
            return option
        }
        return command.options.first
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                header
                infoGrid
                
                section(title: "What it does") {
                    Text(command.summary)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                section(title: "Read Command") {
                    CodeBlockView(command: command.readCommand(), onCopy: onCopy)
                }
                
                optionsSection
                
                Text("Tip: copy a command and paste it into Terminal with ⌘V, or use the Terminal button in the lower-right corner to run it directly.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .overlay(alignment: .bottomTrailing) {
            terminalButton
                .padding(20)
        }
        .onAppear {
            if selectedOptionID == nil {
                selectedOptionID = command.options.first?.id
            }
        }
    }
    
    // MARK: - Sections
    
    private var header: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: command.category.icon)
                .font(.title2)
                .foregroundStyle(Color.accentColor)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(command.title)
                    .font(.title2)
                    .bold()
                Text(command.category.displayName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            typeBadge
        }
    }
    
    private var infoGrid: some View {
        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 10) {
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
        .padding(12)
        .background(.quaternary.opacity(0.4), in: RoundedRectangle(cornerRadius: 10))
    }
    
    private var reloadRequirement: String {
        if let app = command.restartApplication {
            return "Restart \(app)"
        }
        return "Applies immediately"
    }
    
    private var optionsSection: some View {
        section(title: "Adjustable Options") {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 10) {
                    Picker("Option", selection: $selectedOptionID) {
                        ForEach(command.options) { option in
                            Text(option.label).tag(Optional(option.id))
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(minWidth: 220)
                    
                    Spacer()
                    
                    Button(action: {
                        if let option = selectedOption {
                            onCopy(command.writeCommand(for: option))
                        }
                    }) {
                        Label("Copy Command", systemImage: "doc.on.doc")
                    }
                    .buttonStyle(.bordered)
                    .disabled(selectedOption == nil)
                    
                    Button(action: applyAndRestart) {
                        Label("Apply & Restart", systemImage: "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedOption == nil)
                }
                
                if let option = selectedOption {
                    if let detail = option.detail {
                        Text(detail)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    CodeBlockView(command: command.writeCommand(for: option), onCopy: onCopy)
                }
            }
        }
    }
    
    private var terminalButton: some View {
        Button(action: openInTerminal) {
            VStack(spacing: 4) {
                Image(systemName: "terminal.fill")
                    .font(.title2)
                Text("Terminal")
                    .font(.caption2)
                    .bold()
            }
            .frame(width: 66, height: 56)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(radius: 4, y: 2)
        .disabled(selectedOption == nil)
        .help("Run the selected command in Terminal")
    }
    
    // MARK: - Helpers
    
    private func infoLabel(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundStyle(.secondary)
    }
    
    private func infoValue(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .monospaced()
            .textSelection(.enabled)
    }
    
    private var typeBadge: some View {
        Text(command.type.displayName)
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
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
        }
    }
    
    @ViewBuilder
    private func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
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
        if target.contains("disk utility") || target.contains("diskutility") {
            commands.append("killall \"Disk Utility\" 2>/dev/null || killall DiskUtility 2>/dev/null")
        }
        return commands
    }
    
    private func runShell(_ shellCommand: String, withPrivileges: Bool, completion: @escaping (NSDictionary?) -> Void) {
        let escaped = shellCommand
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
        let suffix = withPrivileges ? " with administrator privileges" : ""
        let script = "do shell script \"\(escaped)\"\(suffix)"
        var error: NSDictionary?
        NSAppleScript(source: script)?.executeAndReturnError(&error)
        completion(error)
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
        
        runShell(shellCmd, withPrivileges: true) { error in
            if let error = error {
                let msg = error[NSAppleScript.errorMessage] as? String ?? "Unknown error"
                authGranted = false
                presentAlert(
                    title: "Failed to apply change",
                    message: "\(msg)\n\nThe command was copied to the clipboard:\n\(writeCmd)",
                    style: .warning
                )
                return
            }
            
            authGranted = true
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
    
    @State private var hovered = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(command)
                .font(.system(.callout, design: .monospaced))
                .lineLimit(1)
                .truncationMode(.middle)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                onCopy(command)
            }) {
                Image(systemName: "doc.on.doc")
            }
            .buttonStyle(.borderless)
            .help("Copy to clipboard (then paste in Terminal with ⌘V)")
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(.background, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(.separator.opacity(0.4))
        )
    }
}