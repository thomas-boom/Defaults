import CoreText
import Foundation

/// Registers the JetBrains Mono files that ship inside the app bundle.
///
/// The fonts live in `Defaults/Fonts/` and are copied into the app's Resources,
/// so the interface keeps its monospaced look on Macs that don't have JetBrains
/// Mono installed. Registration only affects this process — nothing is
/// installed system-wide.
enum BundledFonts {
    private static let fontExtensions: Set<String> = ["ttf", "otf", "ttc"]
    
    static func register() {
        guard let resourceURL = Bundle.main.resourceURL,
              let walker = FileManager.default.enumerator(
                at: resourceURL,
                includingPropertiesForKeys: nil
              ) else { return }
        
        for case let url as URL in walker where fontExtensions.contains(url.pathExtension.lowercased()) {
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}
