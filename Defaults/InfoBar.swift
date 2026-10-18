import SwiftUI
import AppKit

/// App metadata shown in the information bar and its popover.
/// Edit `author` and `repoURL` to point at your own repository.
enum AppInfo {
    static let name = "Defaults"
    static let author = "Thomas Boom"
    static let repoURL = URL(string: "https://github.com/thomasboom/Defaults")!
    
    static var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    static var year: String {
        String(Calendar.current.component(.year, from: Date()))
    }
}

/// A slim bar that hovers over the bottom of the window. It shows the app name,
/// version, year, and an info button that opens a popover with the author,
/// repository link and app icon.
struct InfoBar: View {
    @State private var showInfo = false
    @State private var hovering = false
    
    var body: some View {
        HStack(spacing: 10) {
            appIcon(size: 18)
            
            Text(AppInfo.name)
                .font(.jb(12, .semibold))
            
            Text("v\(AppInfo.version)")
                .font(.jb(10))
                .foregroundStyle(.secondary)
            
            Button {
                showInfo.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 13))
            }
            .buttonStyle(.plain)
            .help("About this app")
            .popover(isPresented: $showInfo, arrowEdge: .top) {
                infoPopover
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial, in: Capsule())
        .overlay(
            Capsule().strokeBorder(.separator.opacity(0.35))
        )
        .shadow(color: .black.opacity(hovering ? 0.22 : 0.12), radius: hovering ? 6 : 3, y: 2)
        .padding(.trailing, 10)
        .padding(.bottom, 10)
        .onHover { isHovering in
            withAnimation(.easeInOut(duration: 0.15)) {
                hovering = isHovering
            }
        }
    }
    
    private var infoPopover: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                appIcon(size: 40)
                VStack(alignment: .leading, spacing: 2) {
                    Text(AppInfo.name)
                        .font(.jb(13, .semibold))
                    Text("View & apply macOS defaults")
                        .font(.jb(10))
                        .foregroundStyle(.secondary)
                }
            }
            
            Divider()
            
            infoRow(label: "Author", value: AppInfo.author, symbol: "person")
            infoRow(label: "Year", value: AppInfo.year, symbol: "calendar")
            
            Link(destination: AppInfo.repoURL) {
                HStack(spacing: 6) {
                    Image(systemName: "link")
                    Text(AppInfo.repoURL.absoluteString)
                        .lineLimit(1)
                        .truncationMode(.middle)
                }
                .font(.jb(10))
            }
            .help("Open the GitHub repository")
        }
        .padding(14)
        .frame(width: 300, alignment: .leading)
    }
    
    @ViewBuilder
    private func appIcon(size: CGFloat) -> some View {
        if let icon = NSApplication.shared.applicationIconImage {
            Image(nsImage: icon)
                .resizable()
                .interpolation(.high)
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
        } else {
            Image(systemName: "terminal.fill")
                .font(.system(size: size * 0.8))
                .foregroundStyle(.primary)
                .frame(width: size, height: size)
        }
    }
    
    private func infoRow(label: String, value: String, symbol: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: symbol)
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
                .frame(width: 14)
            Text(label)
                .font(.jb(10))
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.jb(10, .medium))
        }
    }
}
