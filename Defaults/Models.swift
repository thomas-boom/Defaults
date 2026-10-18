import SwiftUI

enum DefaultsCategory: String, CaseIterable, Identifiable, Codable {
    case system
    case dock
    case finder
    case safari
    case mail
    case missionControl
    case dashboard
    case textEdit
    case diskUtility
    case softwareUpdate
    case appStore
    case terminal
    case xcode
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .system:
            return "System (Global)"
        case .dock:
            return "Dock"
        case .finder:
            return "Finder"
        case .safari:
            return "Safari"
        case .mail:
            return "Mail"
        case .missionControl:
            return "Mission Control & Spaces"
        case .dashboard:
            return "Dashboard"
        case .textEdit:
            return "TextEdit"
        case .diskUtility:
            return "Disk Utility"
        case .softwareUpdate:
            return "Software Update"
        case .appStore:
            return "App Store"
        case .terminal:
            return "Terminal"
        case .xcode:
            return "Xcode"
        }
    }
    
    var icon: String {
        switch self {
        case .system:
            return "desktopcomputer"
        case .dock:
            return "dock.rectangle"
        case .finder:
            return "folder.fill"
        case .safari:
            return "compass"
        case .mail:
            return "envelope"
        case .missionControl:
            return "rectangle.2.swap"
        case .dashboard:
            return "rectangle.grid.2x2"
        case .textEdit:
            return "doc.text"
        case .diskUtility:
            return "harddrive"
        case .softwareUpdate:
            return "arrow.clockwise"
        case .appStore:
            return "bag"
        case .terminal:
            return "terminal"
        case .xcode:
            return "hammer"
        }
    }
}

enum DefaultsValueType: String, Codable {
    case bool
    case int
    case float
    case string
    case enumType
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
    
    init(id: UUID = UUID(), category: DefaultsCategory, domain: String, key: String, title: String, summary: String, type: DefaultsValueType, options: [DefaultsOption], default: String? = nil, restartApplication: String? = nil) {
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
    }
    
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