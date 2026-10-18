import SwiftUI
import AppKit

struct CommandRowView: View {
    let command: DefaultsCommand
    let onCopy: (String) -> Void
    
    @State private var selectedOptionID: UUID
    
    init(command: DefaultsCommand, onCopy: @escaping (String) -> Void) {
        self.command = command
        self.onCopy = onCopy
        self._selectedOptionID = State(initialValue: command.options.first?.id ?? UUID())
    }
    
    private var selectedOption: DefaultsOption? {
        command.options.first { $0.id == selectedOptionID }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: command.category.icon)
                    .foregroundStyle(.accent)
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
                            VStack(alignment: .leading) {
                                Text(option.label)
                            }
                            .tag(option.id)
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
            case .bool:
                Text("Bool")
            case .int:
                Text("Int")
            case .float:
                Text("Float")
            case .string:
                Text("String")
            case .enumType:
                Text("Enum")
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
        case .bool:
            return .blue
        case .int, .float:
            return .purple
        case .string, .enumType:
            return .green
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