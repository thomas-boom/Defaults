import SwiftUI

/// Centralized typography. The app uses JetBrains Mono everywhere: the font
/// files ship inside the app bundle (`Defaults/Fonts/`) and are registered at
/// launch by `BundledFonts.register()`, so nothing has to be installed.
extension Font {
    static func jb(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        .custom("JetBrains Mono", size: size).weight(weight)
    }
}

enum AppMetrics {
    static let baseFontSize: CGFloat = 12
    static let minWindowWidth: CGFloat = 640
    static let minWindowHeight: CGFloat = 420
    static let defaultWindowWidth: CGFloat = 760
    static let defaultWindowHeight: CGFloat = 520
}
