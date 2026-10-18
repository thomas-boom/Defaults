import SwiftUI
import AppKit

struct CommandRowView: View {
    let command: DefaultsCommand
    @Binding var authGranted: Bool
    let onCopy: (String) -> Void
    
    @State private var selectedOptionID: UUID
    
    init(command: DefaultsCommand, authGranted: Binding<Bool>, onCopy: @escaping (String) -> Void) {
        self.command = command
        self._authGranted = authGranted
        self.onCopy = onCopy
        self._selectedOptionID = State(initialValue: command.options.first?.id ?? UUID())
    }
    
    private var selectedOption: DefaultsOption? {
        command.options.first { $0.id == selectedOptionID }
    }
    
    private func restartTarget() -> String? {
        return command.restartApplication
    }
    
    private func applyAndRestart() {
        guard let option = selectedOption else { return }
        let writeCmd = command.writeCommand(for: option)
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(writeCmd, forType: .string)
        onCopy(writeCmd)
        
        let targetRaw = restartTarget() ?? ""
        let target = targetRaw.lowercased()
        
        var commands: [String] = []
        commands.append(writeCmd)
        
        if target.contains("dock") {
            commands.append("killall Dock")
        }
        if target.contains("finder") {
            commands.append("killall Finder")
        }
        if target.contains("safari") {
            commands.append("killall Safari")
        }
        if target.contains("mail") {
            commands.append("killall Mail")
        }
        if target.contains("terminal") {
            commands.append("killall Terminal")
        }
        if target.contains("textedit") {
            commands.append("killall TextEdit")
        }
        if target.contains("xcode") {
            commands.append("killall Xcode")
        }
        if target.contains("disk utility") || target.contains("diskutility") {
            commands.append("killall \"Disk Utility\" 2>/dev/null || killall DiskUtility 2>/dev/null")
        }
        
        let shellCmd = commands.joined(separator: "; ")
        let script = "do shell script \"\(shellCmd)\" with administrator privileges"
        let appleScript = NSAppleScript(source: script)
        var error: NSDictionary?
        _ = appleScript?.executeAndReturnError(&error)
        
        if let error = error {
            let msg = error[NSAppleScript.errorMessage] as? String ?? "Unknown error"
            authGranted = false
            let alert = NSAlert()
            alert.messageText = "Failed to apply change"
            alert.informativeText = "\(msg)\n\nCommand copied to clipboard:\n\(writeCmd)"
            alert.alertStyle = .warning
            alert.runModal()
            return
        }
        
        authGranted = true
        let alert = NSAlert()
        if target.contains("log out") {
            alert.messageText = "Applied"
            alert.informativeText = "Executed with elevated privileges:\n\(writeCmd)\n\nThis change requires logging out and back in to take full effect."
        } else if target.contains("relaunch apps") {
            alert.messageText = "Applied"
            alert.informativeText = "Executed with elevated privileges:\n\(writeCmd)\n\nYou may need to relaunch affected apps for the change to take effect."
        } else if commands.count > 1 {
            alert.messageText = "Applied & Restarted"
            alert.informativeText = "Executed with elevated privileges:\n\(shellCmd)"
        } else {
            alert.messageText = "Applied"
            alert.informativeText = "Executed with elevated privileges:\n\(writeCmd)"
        }
        alert.alertStyle = .informational
        alert.runModal()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: command.category.icon)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 20)
                Text(command.title)
                    .font(.headline)
                Spacer()
                typeBadge
            }
            Text(command.summary)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            HStack(spacing: 8) {
                HStack(spacing: 4) {
                    Text("Domain:")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text(command.domain)
                        .font(.caption2)
                        .monospaced()
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                }
                HStack(spacing: 4) {
                    Text("Key:")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text(command.key)
                        .font(.caption2)
                        .monospaced()
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                }
                if let app = command.restartApplication {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.clockwise")
                            .font(.caption2)
                        Text(app)
                            .font(.caption2)
                    }
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 4))
                }
            }
            Divider()
            VStack(alignment: .leading, spacing: 6) {
                Text("Read command")
                    .font(.caption2)
                    .bold()
                CodeBlockView(command: command.readCommand(), onCopy: onCopy)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Adjustable Options")
                    .font(.caption2)
                    .bold()
                HStack(spacing: 8) {
                    Picker("Options", selection: $selectedOptionID) {
                        ForEach(command.options) { option in
                            Text(option.label).tag(option.id)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(minWidth: 200)
                    Button(action: {
                        if let option = selectedOption {
                            onCopy(command.writeCommand(for: option))
                        }
                    }) {
                        Label("Copy Write Command", systemImage: "doc.on.doc")
                    }
                    .buttonStyle(.bordered)
                    Button(action: applyAndRestart) {
                        Label("Apply & Restart", systemImage: "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedOption == nil)
                }
                if let option = selectedOption, let detail = option.detail {
                    Text(detail)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                if let option = selectedOption {
                    CodeBlockView(command: command.writeCommand(for: option), onCopy: onCopy)
                }
            }
            if let dflt = command.default {
                Text("Default: \(dflt)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.separator.opacity(0.2))
        )
    }
    private var typeBadge: some View {
        Group {
            switch command.type {
            case .bool: Text("Bool")
            case .int: Text("Int")
            case .float: Text("Float")
            case .string: Text("String")
            case .enumType: Text("Enum")
            }
        }
        .font(.caption2)
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(typeColor.opacity(0.15), in: Capsule())
        .foregroundStyle(typeColor)
    }
    private var typeColor: Color {
        switch command.type {
        case .bool: return .blue
        case .int, .float: return .purple
        case .string, .enumType: return .green
        }
    }
}

struct CodeBlockView: View {
    let command: String
    let onCopy: (String) -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text(command)
                .font(.system(.caption, design: .monospaced))
                .lineLimit(1)
                .truncationMode(.middle)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                onCopy(command)
            }) {
                Image(systemName: "doc.on.doc")
                    .font(.caption2)
            }
            .buttonStyle(.borderless)
            .help("Copy to clipboard")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(.background, in: RoundedRectangle(cornerRadius: 6))
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .strokeBorder(.separator.opacity(0.3))
        )
    }
}