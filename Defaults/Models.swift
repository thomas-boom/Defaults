import SwiftUI

enum DefaultsCategory: String, CaseIterable, Identifiable, Codable {
    // Desktop
    case dock
    case finder
    case missionControl
    case dashboard
    case menuBarClock
    case screenshots
    
    // Apps
    case safari
    case mail
    case textEdit
    case terminal
    case xcode
    
    // System
    case system
    case keyboard
    case loginWindow
    case screensaver
    case airDrop
    case crashReporter
    case dsStore
    case diskUtility
    case softwareUpdate
    case appStore
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .dock: return "Dock"
        case .finder: return "Finder"
        case .missionControl: return "Mission Control & Spaces"
        case .dashboard: return "Dashboard"
        case .menuBarClock: return "Menu Bar Clock"
        case .screenshots: return "Screenshots"
        case .safari: return "Safari"
        case .mail: return "Mail"
        case .textEdit: return "TextEdit"
        case .terminal: return "Terminal"
        case .xcode: return "Xcode"
        case .system: return "System (Global)"
        case .keyboard: return "Keyboard"
        case .loginWindow: return "Login Window"
        case .screensaver: return "Screensaver"
        case .airDrop: return "AirDrop"
        case .crashReporter: return "Crash Reporter"
        case .dsStore: return ".DS_Store"
        case .diskUtility: return "Disk Utility"
        case .softwareUpdate: return "Software Update"
        case .appStore: return "App Store"
        }
    }
    
    /// SF Symbol used as a fallback when no real app icon is available.
    var icon: String {
        switch self {
        case .dock: return "dock.rectangle"
        case .finder: return "folder.fill"
        case .missionControl: return "rectangle.2.swap"
        case .dashboard: return "rectangle.grid.2x2"
        case .menuBarClock: return "clock"
        case .screenshots: return "camera.viewfinder"
        case .safari: return "compass"
        case .mail: return "envelope"
        case .textEdit: return "doc.text"
        case .terminal: return "terminal"
        case .xcode: return "hammer"
        case .system: return "desktopcomputer"
        case .keyboard: return "keyboard"
        case .loginWindow: return "person.crop.square"
        case .screensaver: return "sparkles.tv"
        case .airDrop: return "dot.radiowaves.left.and.right"
        case .crashReporter: return "exclamationmark.triangle"
        case .dsStore: return "externaldrive"
        case .diskUtility: return "harddrive"
        case .softwareUpdate: return "arrow.clockwise"
        case .appStore: return "bag"
        }
    }
    
    /// Path to the matching system app bundle, used to load the real app icon
    /// so Safari, Disk Utility, etc. look like the actual apps.
    var appPath: String? {
        switch self {
        case .finder: return "/System/Library/CoreServices/Finder.app"
        case .safari: return "/Applications/Safari.app"
        case .mail: return "/System/Applications/Mail.app"
        case .textEdit: return "/System/Applications/TextEdit.app"
        case .terminal: return "/System/Applications/Utilities/Terminal.app"
        case .xcode: return "/Applications/Xcode.app"
        case .diskUtility: return "/System/Applications/Utilities/Disk Utility.app"
        case .appStore: return "/System/Applications/App Store.app"
        default: return nil
        }
    }
}

enum DefaultsValueType: String, Codable {
    case bool
    case int
    case float
    case string
    case enumType
    
    var displayName: String {
        switch self {
        case .bool:
            return "Boolean"
        case .int:
            return "Integer"
        case .float:
            return "Float"
        case .string:
            return "String"
        case .enumType:
            return "Choice"
        }
    }
}

struct DefaultsOption: Identifiable, Codable, Hashable {
    let id: UUID
    let value: String
    let label: String
    let detail: String?
    
    init(id: UUID = UUID(), value: String, label: String, detail: String? = nil) {
        self.id = id
        self.value = value
        self.label = label
        self.detail = detail
    }
}

struct DefaultsCommand: Identifiable, Codable, Hashable {
    let id: UUID
    let category: DefaultsCategory
    let domain: String
    let key: String
    let title: String
    let summary: String
    let type: DefaultsValueType
    let options: [DefaultsOption]
    let `default`: String?
    let restartApplication: String?
    /// Non-nil when changing this setting can break behaviour or destroy data.
    /// Rendered as a warning triangle in the list and a banner in the detail view.
    let risk: String?
    
    init(id: UUID = UUID(), category: DefaultsCategory, domain: String, key: String, title: String, summary: String, type: DefaultsValueType, options: [DefaultsOption], default: String? = nil, restartApplication: String? = nil, risk: String? = nil) {
        self.id = id
        self.category = category
        self.domain = domain
        self.key = key
        self.title = title
        self.summary = summary
        self.type = type
        self.options = options
        self.default = `default`
        self.restartApplication = restartApplication
        self.risk = risk
    }
    
    var hasRisk: Bool { risk != nil }
    
    var fullKeyPath: String {
        return "\(domain) \(key)"
    }
    
    func readCommand() -> String {
        return "defaults read \(domain) \(key)"
    }
    
    func writeCommand(for option: DefaultsOption) -> String {
        switch type {
        case .bool:
            return "defaults write \(domain) \(key) -bool \(option.value)"
        case .int:
            return "defaults write \(domain) \(key) -int \(option.value)"
        case .float:
            return "defaults write \(domain) \(key) -float \(option.value)"
        case .string, .enumType:
            let v = option.value
            if v.contains(" ") {
                return "defaults write \(domain) \(key) -string \"\(v)\""
            } else {
                return "defaults write \(domain) \(key) -string \(v)"
            }
        }
    }
    
    func writeCommandRaw(_ value: String) -> String {
        switch type {
        case .bool:
            return "defaults write \(domain) \(key) -bool \(value)"
        case .int:
            return "defaults write \(domain) \(key) -int \(value)"
        case .float:
            return "defaults write \(domain) \(key) -float \(value)"
        case .string, .enumType:
            if value.contains(" ") {
                return "defaults write \(domain) \(key) -string \"\(value)\""
            } else {
                return "defaults write \(domain) \(key) -string \(value)"
            }
        }
    }
}
