import SwiftUI
import AppKit

struct ContentView: View {
    @State private var selectedCategory: DefaultsCategory? = nil
    @State private var searchText = ""
    @State private var copiedCommand: String? = nil
    
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
                        CommandRowView(command: command) { copied in
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
    }
    
    private func copyToClipboard(_ string: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(string, forType: .string)
        copiedCommand = string
    }
}

#Preview {
    ContentView()
}