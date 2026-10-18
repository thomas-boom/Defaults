import SwiftUI
import AppKit

/// Loads the real macOS app icons (Safari, Disk Utility, Mail, Terminal, …)
/// via NSWorkspace so the sidebar/list match the actual apps. Results are
/// cached. Falls back to an SF Symbol when an app can't be found or the
/// sandbox blocks the lookup.
enum AppIconLoader {
    private static var cache: [String: NSImage] = [:]
    
    static func icon(for path: String) -> NSImage? {
        if let cached = cache[path] {
            return cached
        }
        guard FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        let image = NSWorkspace.shared.icon(forFile: path)
        image.size = NSSize(width: 64, height: 64)
        cache[path] = image
        return image
    }
}

/// Renders a category's icon: the real app icon when available, otherwise the
/// category's SF Symbol tinted with its accent color.
struct CategoryIcon: View {
    let category: DefaultsCategory
    var size: CGFloat = 16
    
    var body: some View {
        Group {
            if let path = category.appPath, let image = AppIconLoader.icon(for: path) {
                Image(nsImage: image)
                    .resizable()
                    .interpolation(.high)
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: category.icon)
                    .font(.system(size: size * 0.82))
                    .foregroundStyle(category.accentColor)
            }
        }
        .frame(width: size, height: size)
    }
}
