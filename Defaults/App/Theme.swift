import SwiftUI

/// Centralized typography. The app uses JetBrains Mono everywhere.
/// The font is resolved by family name; if it is not installed the system
/// falls back to the default monospaced-ish font automatically.
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
