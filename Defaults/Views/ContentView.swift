import SwiftUI
import AppKit

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    @State private var sidebarSelection: SidebarItem? = .category(.dock)
    @State private var selectedCommandID: DefaultsCommand.ID?
    @State private var searchText = ""
    @State private var showCopyToast = false
    @State private var toastResetTask: Task<Void, Never>?
    
    private var selectedCategory: DefaultsCategory? {
        switch sidebarSelection {
        case .category(let category):
            return category
        case .all, .none:
            return nil
        }
    }
    
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
    
    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        return "v\(version)"
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
            SidebarView(
                selection: $sidebarSelection,
                authGranted: appState.authGranted,
                appVersion: appVersion,
                onAuthorize: appState.requestAuth
            )
            .navigationSplitViewColumnWidth(min: 180, ideal: 200, max: 260)
        } content: {
            commandList
                .navigationSplitViewColumnWidth(min: 190, ideal: 230, max: 320)
        } detail: {
            detailPane
        }
        .navigationSplitViewStyle(.balanced)
        .font(.jb(AppMetrics.baseFontSize))
        .overlay(alignment: .top) {
            if showCopyToast {
                copyToast
            }
        }
        .overlay(alignment: .bottomTrailing) {
            InfoBar()
        }
        .frame(minWidth: AppMetrics.minWindowWidth, minHeight: AppMetrics.minWindowHeight)
        .background(WindowBackdrop())
        .sheet(isPresented: $appState.showAuthSheet) {
            AuthSheet()
                .environmentObject(appState)
        }
        .onAppear {
            if selectedCommandID == nil {
                selectedCommandID = commandsInCategory.first?.id
            }
        }
        .onChange(of: sidebarSelection) { _, _ in
            if let id = selectedCommandID,
               !commandsInCategory.contains(where: { $0.id == id }) {
                selectedCommandID = commandsInCategory.first?.id
            } else if selectedCommandID == nil {
                selectedCommandID = commandsInCategory.first?.id
            }
        }
    }
    
    // MARK: - Command List
    
    private var commandList: some View {
        List(selection: $selectedCommandID) {
            ForEach(commandsInCategory) { command in
                CommandListRow(command: command)
                    .tag(command.id)
            }
        }
        .contentMargins(.bottom, 10, for: .scrollContent)
        .navigationTitle(selectedCategory?.displayName ?? "All Commands")
        .searchable(text: $searchText, placement: .toolbar, prompt: "Search")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                terminalButton
            }
        }
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
            CommandDetailView(command: command, onCopy: copyToClipboard)
                .id(command.id)
        } else {
            ContentUnavailableView(
                "Select a Command",
                systemImage: "sidebar.right",
                description: Text("Choose a command to view its details and run it in Terminal")
            )
        }
    }
    
    private var copyToast: some View {
        Text("Copied to clipboard")
            .font(.jb(11))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.thinMaterial, in: Capsule())
            .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    /// Plain toolbar symbol that only brings Terminal forward; the command is
    /// copied by hand with ⌘V, nothing is run here.
    private var terminalButton: some View {
        Button(action: openTerminal) {
            Image(systemName: "terminal.fill")
                .font(.system(size: 15, weight: .medium))
        }
        .buttonStyle(.plain)
        .help("Open Terminal")
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
    
    /// Opens Terminal.app only — no command is run for the user.
    private func openTerminal() {
        NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Applications/Utilities/Terminal.app"))
    }
    
}

struct CommandListRow: View {
    let command: DefaultsCommand
    
    var body: some View {
        HStack(spacing: 8) {
            CategoryIcon(category: command.category, size: 16)
            
            VStack(alignment: .leading, spacing: 1) {
                Text(command.title)
                    .font(.jb(12, .medium))
                    .lineLimit(1)
                Text("\(command.domain) \(command.key)")
                    .font(.jb(9))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
            }
            
            Spacer(minLength: 4)
            
            if command.hasRisk {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 11))
                    .foregroundStyle(.orange)
                    .help(command.risk ?? "Use with caution")
            }
        }
        .padding(.vertical, 1)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
