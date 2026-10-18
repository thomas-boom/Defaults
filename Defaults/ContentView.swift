import SwiftUI
import AppKit

struct ContentView: View {
    @State private var selectedCategory: DefaultsCategory? = .dock
    @State private var selectedCommandID: DefaultsCommand.ID?
    @State private var searchText = ""
    @State private var showCopyToast = false
    @State private var toastResetTask: Task<Void, Never>?
    @State private var authGranted = false
    
    private var commandsInCategory: [DefaultsCommand] {
        CommandStore.allCommands
            .filter { selectedCategory == nil || $0.category == selectedCategory }
            .filter { matchesSearch($0) }
            .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
    }
    
    private var selectedCommand: DefaultsCommand? {
        guard let id = selectedCommandID else { return nil }
        return CommandStore.allCommands.first { $0.id == id }
    }
    
    private func matchesSearch(_ command: DefaultsCommand) -> Bool {
        guard !searchText.isEmpty else { return true }
        let query = searchText.lowercased()
        return command.title.lowercased().contains(query) ||
               command.summary.lowercased().contains(query) ||
               command.domain.lowercased().contains(query) ||
               command.key.lowercased().contains(query)
    }
    
    var body: some View {
        NavigationSplitView {
            sidebar
        } content: {
            commandList
        } detail: {
            detailPane
        }
        .navigationSplitViewStyle(.balanced)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: requestAuth) {
                    Label(authGranted ? "Access Granted" : "Request Access",
                          systemImage: authGranted ? "lock.open.fill" : "lock.shield")
                }
                .help("Authorize once so system processes can be restarted without repeated prompts")
            }
        }
        .overlay(alignment: .top) {
            if showCopyToast {
                copyToast
            }
        }
        .frame(minWidth: 900, minHeight: 560)
        .onAppear {
            if selectedCommandID == nil {
                selectedCommandID = commandsInCategory.first?.id
            }
            requestAuth()
        }
        .onChange(of: selectedCategory) { _, _ in
            if let id = selectedCommandID,
               !commandsInCategory.contains(where: { $0.id == id }) {
                selectedCommandID = commandsInCategory.first?.id
            } else if selectedCommandID == nil {
                selectedCommandID = commandsInCategory.first?.id
            }
        }
    }
    
    // MARK: - Sidebar
    
    private var sidebar: some View {
        List(selection: $selectedCategory) {
            Label("All Commands", systemImage: "square.grid.2x2")
                .tag(DefaultsCategory?.none)
            
            Section("Categories") {
                ForEach(DefaultsCategory.allCases) { category in
                    Label {
                        HStack {
                            Text(category.displayName)
                            Spacer()
                            Text("\(count(for: category))")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    } icon: {
                        Image(systemName: category.icon)
                    }
                    .tag(Optional(category))
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("Defaults")
    }
    
    private func count(for category: DefaultsCategory) -> Int {
        CommandStore.allCommands.filter { $0.category == category }.count
    }
    
    // MARK: - Command List
    
    private var commandList: some View {
        List(selection: $selectedCommandID) {
            ForEach(commandsInCategory) { command in
                CommandListRow(command: command)
                    .tag(Optional(command.id))
            }
        }
        .navigationTitle(selectedCategory?.displayName ?? "All Commands")
        .searchable(text: $searchText, placement: .toolbar, prompt: "Search commands")
        .overlay {
            if commandsInCategory.isEmpty {
                ContentUnavailableView(
                    "No commands found",
                    systemImage: "magnifyingglass",
                    description: Text("Try a different search or category")
                )
            }
        }
    }
    
    // MARK: - Detail
    
    @ViewBuilder
    private var detailPane: some View {
        if let command = selectedCommand {
            CommandDetailView(command: command, authGranted: $authGranted, onCopy: copyToClipboard)
                .id(command.id)
        } else {
            ContentUnavailableView(
                "Select a Command",
                systemImage: "sidebar.right",
                description: Text("Choose a command from the list to view its details, options, and run it in Terminal")
            )
        }
    }
    
    private var copyToast: some View {
        Text("Copied to clipboard")
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(.thinMaterial, in: Capsule())
            .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    // MARK: - Actions
    
    private func copyToClipboard(_ string: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(string, forType: .string)
        
        withAnimation(.easeInOut(duration: 0.2)) {
            showCopyToast = true
        }
        
        toastResetTask?.cancel()
        toastResetTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(2))
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 0.2)) {
                showCopyToast = false
            }
        }
    }
    
    private func requestAuth() {
        let script = "do shell script \"true\" with administrator privileges"
        var error: NSDictionary?
        NSAppleScript(source: script)?.executeAndReturnError(&error)
        authGranted = (error == nil)
    }
}

struct CommandListRow: View {
    let command: DefaultsCommand
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: command.category.icon)
                .foregroundStyle(Color.accentColor)
                .frame(width: 22)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(command.title)
                    .font(.body)
                    .lineLimit(1)
                Text("\(command.domain) \(command.key)")
                    .font(.caption2)
                    .monospaced()
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    ContentView()
}