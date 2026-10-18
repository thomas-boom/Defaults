import SwiftUI

// MARK: - Sidebar item

/// Explicit, non-optional selection type for the sidebar.
/// Using a dedicated enum avoids the nil-collision that broke selection before.
enum SidebarItem: Hashable {
    case all
    case category(DefaultsCategory)
    
    var title: String {
        switch self {
        case .all:
            return "All Commands"
        case .category(let category):
            return category.displayName
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            return "square.grid.2x2"
        case .category(let category):
            return category.icon
        }
    }
    
    var accentColor: Color {
        switch self {
        case .all:
            return .accentColor
        case .category(let category):
            return category.accentColor
        }
    }
    
    var isProminent: Bool {
        if case .all = self { return true }
        return false
    }
}

// MARK: - Sections

/// Logical grouping of the macOS areas shown in the sidebar.
enum SidebarSection: String, CaseIterable, Identifiable {
    case desktop
    case apps
    case system
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .desktop: return "Desktop"
        case .apps: return "Apps"
        case .system: return "System"
        }
    }
    
    var categories: [DefaultsCategory] {
        DefaultsCategory.allCases.filter { $0.sidebarSection == self }
    }
}

extension DefaultsCategory {
    var sidebarSection: SidebarSection {
        switch self {
        case .dock, .finder, .missionControl, .dashboard, .menuBarClock, .screenshots:
            return .desktop
        case .safari, .mail, .textEdit, .terminal, .xcode:
            return .apps
        case .system, .keyboard, .loginWindow, .screensaver, .airDrop,
             .crashReporter, .dsStore, .diskUtility, .softwareUpdate, .appStore:
            return .system
        }
    }
    
    /// Per-category tint used for the sidebar icon, mirroring the
    /// themed icons in the reference design.
    var accentColor: Color {
        switch self {
        case .system: return .gray
        case .dock: return .blue
        case .finder: return .cyan
        case .safari: return .blue
        case .mail: return .indigo
        case .missionControl: return .purple
        case .dashboard: return .teal
        case .menuBarClock: return .gray
        case .screenshots: return .pink
        case .textEdit: return .brown
        case .diskUtility: return .orange
        case .softwareUpdate: return .green
        case .appStore: return .blue
        case .terminal: return .green
        case .xcode: return .blue
        case .keyboard: return .gray
        case .loginWindow: return .indigo
        case .screensaver: return .mint
        case .airDrop: return .cyan
        case .crashReporter: return .red
        case .dsStore: return .orange
        }
    }
}

// MARK: - Sidebar view

struct SidebarView: View {
    @Binding var selection: SidebarItem?
    let authGranted: Bool
    let appVersion: String
    let onAuthorize: () -> Void
    
    /// Sections the user has folded away. Native `.sidebar` sections don't
    /// fold on a title click, so we render our own always-visible chevron
    /// headers that collapse on tap.
    @State private var collapsedSections: Set<SidebarSection> = []
    
    var body: some View {
        VStack(spacing: 0) {
            List(selection: $selection) {
                sidebarRow(.all)
                
                ForEach(SidebarSection.allCases) { section in
                    sectionHeader(section)
                    if !collapsedSections.contains(section) {
                        ForEach(section.categories) { category in
                            sidebarRow(.category(category))
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            
            Divider().opacity(0.4)
            
            authorizeFooter
        }
        .frame(minWidth: 180, idealWidth: 200)
    }
    
    @ViewBuilder
    private func sidebarRow(_ item: SidebarItem) -> some View {
        Label {
            Text(item.title)
                .font(.jb(12, item.isProminent ? .semibold : .regular))
        } icon: {
            switch item {
            case .all:
                Image(systemName: item.icon)
                    .foregroundStyle(item.accentColor)
            case .category(let category):
                CategoryIcon(category: category, size: 15)
            }
        }
        .tag(item)
    }
    
    private func sectionHeader(_ section: SidebarSection) -> some View {
        let isCollapsed = collapsedSections.contains(section)
        return HStack(spacing: 6) {
            Image(systemName: isCollapsed ? "chevron.right" : "chevron.down")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.secondary)
                .frame(width: 12)
            Text(section.title.uppercased())
                .font(.jb(10, .semibold))
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.top, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.18)) {
                if isCollapsed {
                    collapsedSections.remove(section)
                } else {
                    collapsedSections.insert(section)
                }
            }
        }
        .selectionDisabled()
        .listRowSeparator(.hidden)
    }
    
    private var authorizeFooter: some View {
        Button(action: onAuthorize) {
            HStack(spacing: 8) {
                Image(systemName: authGranted ? "lock.open.fill" : "lock.shield")
                    .font(.system(size: 12))
                    .foregroundStyle(authGranted ? Color.green : Color.secondary)
                Text(authGranted ? "Authorized" : "Authorize")
                    .font(.jb(11, .medium))
                Spacer()
                Text(appVersion)
                    .font(.jb(9))
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .help("Authorize once so system processes can be restarted without repeated prompts")
    }
}
