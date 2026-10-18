import SwiftUI
import AppKit

struct ContentView: View {
    @State private var selectedCategory: DefaultsCategory? = nil
    @State private var searchText = ""
    @State private var copiedCommand: String? = nil
    @State private var authGranted = false
    
    var filteredCommands: [DefaultsCommand] {
        let filtered = CommandStore.allCommands.filter { command in
            let matchesCategory = selectedCategory == nil || command.category == selectedCategory
            if !matchesCategory {
                return false
            }
            
            if searchText.isEmpty {
                return true
            }
            
            let searchLower = searchText.lowercased()
            return command.title.lowercased().contains(searchLower) ||
                   command.summary.lowercased().contains(searchLower) ||
                   command.domain.lowercased().contains(searchLower) ||
                   command.key.lowercased().contains(searchLower)
        }
        
        return filtered.sorted { $0.title < $1.title }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                Picker("Category", selection: $selectedCategory) {
                    Text("All Categories")
                        .tag(DefaultsCategory?.none)
                    
                    Divider()
                    
                    ForEach(DefaultsCategory.allCases) { category in
                        Label(category.displayName, systemImage: category.icon)
                            .tag(Optional(category))
                    }
                }
                .pickerStyle(.menu)
                .frame(minWidth: 240)
                
                TextField("Search commands...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .frame(minWidth: 200, maxWidth: 320)
                
                Spacer()
                
                Text("\(filteredCommands.count) command\(filteredCommands.count == 1 ? "" : "s")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            
            Divider()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(filteredCommands) { command in
                        CommandRowView(command: command, authGranted: $authGranted) { copied in
                            copyToClipboard(copied)
                        }
                    }
                }
                .padding()
            }
            .overlay {
                if filteredCommands.isEmpty {
                    ContentUnavailableView(
                        "No commands found",
                        systemImage: "magnifyingglass",
                        description: Text("Try adjusting your search or selecting a different category")
                    )
                    .padding()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: requestAuth) {
                    Label(authGranted ? "Auth Granted" : "Request Sudo Access", systemImage: authGranted ? "lock.open.fill" : "lock.shield")
                }
                .tint(authGranted ? .green : .accentColor)
            }
        }
        .overlay(alignment: .top) {
            if let copied = copiedCommand {
                Text("Copied to clipboard")
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.thinMaterial, in: Capsule())
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.2), value: copiedCommand)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                copiedCommand = nil
                            }
                        }
                    }
            }
        }
        .frame(minWidth: 700, minHeight: 500)
        .onAppear {
            requestAuth()
        }
    }
    
    private func copyToClipboard(_ string: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(string, forType: .string)
        copiedCommand = string
    }
    
    private func requestAuth() {
        let script = "do shell script \"true\" with administrator privileges"
        let appleScript = NSAppleScript(source: script)
        var error: NSDictionary?
        _ = appleScript?.executeAndReturnError(&error)
        if error == nil {
            authGranted = true
            let alert = NSAlert()
            alert.messageText = "Sudo Access Granted"
            alert.informativeText = "You can now apply and restart system processes without repeated prompts."
            alert.alertStyle = .informational
            alert.runModal()
        } else {
            authGranted = false
            let msg = error?[NSAppleScript.errorMessage] as? String ?? "Permission denied"
            let alert = NSAlert()
            alert.messageText = "Authorization Failed"
            alert.informativeText = msg
            alert.alertStyle = .warning
            alert.runModal()
        }
    }
}

#Preview {
    ContentView()
}