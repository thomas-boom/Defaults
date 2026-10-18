import Foundation

struct CommandStore {
    static let allCommands: [DefaultsCommand] = [
        // MARK: System (Global)
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "AppleShowAllExtensions",
            title: "Show All File Extensions",
            summary: "Display every file extension in Finder regardless of visibility settings",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show all extensions", detail: "Force all filename extensions to be visible"),
                DefaultsOption(value: "false", label: "Use default behavior", detail: "Hide extensions for files set to not show them")
            ],
            default: "false",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "ApplePressAndHoldEnabled",
            title: "Press-and-Hold for Accented Characters",
            summary: "When enabled, pressing and holding a key shows accent popups. When disabled, keys repeat",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable press-and-hold", detail: "Show diacritic popup on key hold"),
                DefaultsOption(value: "false", label: "Enable key repeat", detail: "Get traditional key repeat behavior")
            ],
            default: "true",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "InitialKeyRepeat",
            title: "Initial Key Repeat Delay",
            summary: "Delay (in milliseconds) before a held key begins repeating",
            type: .int,
            options: [
                DefaultsOption(value: "15", label: "15 ms (Very fast)", detail: "Shortest delay"),
                DefaultsOption(value: "25", label: "25 ms (Fast)", detail: "Quick initial repeat"),
                DefaultsOption(value: "35", label: "35 ms (Medium)", detail: "Balanced delay"),
                DefaultsOption(value: "60", label: "60 ms (Slow)", detail: "Longer pause before repeat")
            ],
            default: nil,
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "KeyRepeat",
            title: "Key Repeat Rate",
            summary: "Interval (in milliseconds) between repeated keystrokes",
            type: .int,
            options: [
                DefaultsOption(value: "1", label: "1 ms (Fastest)", detail: "Very rapid key repeat"),
                DefaultsOption(value: "2", label: "2 ms (Fast)", detail: "Rapid key repeat"),
                DefaultsOption(value: "3", label: "3 ms (Medium)", detail: "Standard repeat rate"),
                DefaultsOption(value: "6", label: "6 ms (Slower)", detail: "More controlled repeat")
            ],
            default: nil,
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "com.apple.mouse.scaling",
            title: "Mouse Tracking Speed",
            summary: "Adjust mouse cursor tracking speed",
            type: .float,
            options: [
                DefaultsOption(value: "0.5", label: "0.5 (Slow)", detail: "Precise, slower tracking"),
                DefaultsOption(value: "1.0", label: "1.0 (Default)", detail: "Standard tracking speed"),
                DefaultsOption(value: "2.0", label: "2.0 (Fast)", detail: "Quicker cursor movement"),
                DefaultsOption(value: "3.0", label: "3.0 (Faster)", detail: "High-speed tracking")
            ],
            default: nil,
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "com.apple.trackpad.scaling",
            title: "Trackpad Tracking Speed",
            summary: "Adjust trackpad cursor tracking speed",
            type: .float,
            options: [
                DefaultsOption(value: "0.5", label: "0.5 (Slow)", detail: "Precise control"),
                DefaultsOption(value: "1.0", label: "1.0 (Default)", detail: "Standard sensitivity"),
                DefaultsOption(value: "2.0", label: "2.0 (Fast)", detail: "Responsive tracking"),
                DefaultsOption(value: "3.0", label: "3.0 (Faster)", detail: "High sensitivity")
            ],
            default: nil,
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "com.apple.swipescrolldirection",
            title: "Natural Scrolling",
            summary: "When enabled, content follows your finger direction (like on iOS)",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Natural scrolling", detail: "Content tracks finger movement"),
                DefaultsOption(value: "false", label: "Traditional scrolling", detail: "Scroll bar moves as in older macOS")
            ],
            default: "true",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "AppleInterfaceStyle",
            title: "Interface Appearance",
            summary: "Override system appearance (Dark/Light mode)",
            type: .enumType,
            options: [
                DefaultsOption(value: "Dark", label: "Dark mode", detail: "Use dark interface"),
                DefaultsOption(value: "Light", label: "Light mode", detail: "Use light interface")
            ],
            default: nil,
            restartApplication: nil
        ),
        
        // MARK: Dock
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "autohide",
            title: "Automatically Hide Dock",
            summary: "Hide the Dock when not in use to maximize screen space",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Auto-hide Dock", detail: "Dock slides out when cursor approaches edge"),
                DefaultsOption(value: "false", label: "Show Dock always", detail: "Dock remains visible")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "autohide-delay",
            title: "Dock Auto-Hide Delay",
            summary: "Time delay before the Dock appears after cursor hits edge",
            type: .float,
            options: [
                DefaultsOption(value: "0.0", label: "No delay", detail: "Dock appears instantly"),
                DefaultsOption(value: "0.1", label: "0.1s delay", detail: "Very short delay"),
                DefaultsOption(value: "0.2", label: "0.2s delay", detail: "Short delay"),
                DefaultsOption(value: "0.5", label: "0.5s delay", detail: "Noticeable delay")
            ],
            default: "0.5",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "autohide-time-modifier",
            title: "Dock Hide/Show Animation Speed",
            summary: "Controls the speed of Dock hide/show animation",
            type: .float,
            options: [
                DefaultsOption(value: "0.0", label: "Instant", detail: "No animation"),
                DefaultsOption(value: "0.2", label: "Fast", detail: "Quick animation"),
                DefaultsOption(value: "1.0", label: "Normal", detail: "Default animation speed"),
                DefaultsOption(value: "2.0", label: "Slow", detail: "Slower animation")
            ],
            default: "1.0",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "orientation",
            title: "Dock Position",
            summary: "Position the Dock on screen",
            type: .enumType,
            options: [
                DefaultsOption(value: "bottom", label: "Bottom", detail: "Dock at screen bottom"),
                DefaultsOption(value: "left", label: "Left", detail: "Dock on left edge"),
                DefaultsOption(value: "right", label: "Right", detail: "Dock on right edge")
            ],
            default: "bottom",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "magnification",
            title: "Dock Magnification",
            summary: "Enlarge Dock icons when mouse hovers over them",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable magnification", detail: "Icons grow on hover"),
                DefaultsOption(value: "false", label: "Disable magnification", detail: "Fixed icon size")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "tilesize",
            title: "Dock Icon Size",
            summary: "Size of icons in the Dock (pixels)",
            type: .int,
            options: [
                DefaultsOption(value: "32", label: "Small (32px)", detail: "Compact Dock"),
                DefaultsOption(value: "48", label: "Medium (48px)", detail: "Standard size"),
                DefaultsOption(value: "64", label: "Large (64px)", detail: "Larger icons"),
                DefaultsOption(value: "96", label: "Very Large (96px)", detail: "Prominent Dock")
            ],
            default: nil,
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "largesize",
            title: "Dock Magnified Icon Size",
            summary: "Maximum size when magnification is enabled",
            type: .int,
            options: [
                DefaultsOption(value: "64", label: "64px", detail: "Modest magnification"),
                DefaultsOption(value: "80", label: "80px", detail: "Medium magnification"),
                DefaultsOption(value: "96", label: "96px", detail: "Large magnification"),
                DefaultsOption(value: "128", label: "128px", detail: "Maximum magnification")
            ],
            default: nil,
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "mineffect",
            title: "Minimize Effect",
            summary: "Animation effect when minimizing windows",
            type: .enumType,
            options: [
                DefaultsOption(value: "genie", label: "Genie effect", detail: "Window shrinks to Dock like a genie"),
                DefaultsOption(value: "scale", label: "Scale effect", detail: "Window scales down smoothly"),
                DefaultsOption(value: "suck", label: "Suck effect", detail: "Window is pulled into Dock")
            ],
            default: "genie",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "minimize-to-application",
            title: "Minimize Windows into App Icon",
            summary: "Minimized windows go into the app's Dock icon instead of creating separate Dock icons",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Minimize into app icon", detail: "Cleaner Dock with grouped windows"),
                DefaultsOption(value: "false", label: "Create separate Dock icons", detail: "Show minimized windows separately")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "show-recents",
            title: "Show Recent Applications",
            summary: "Display recently used apps in the Dock",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show recents", detail: "Show recent apps section"),
                DefaultsOption(value: "false", label: "Hide recents", detail: "Hide recent apps from Dock")
            ],
            default: "true",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "show-process-indicators",
            title: "Show App Activity Indicators",
            summary: "Show indicator dots beneath running applications",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show indicators", detail: "Dots appear under active apps"),
                DefaultsOption(value: "false", label: "Hide indicators", detail: "No visual indicators for running apps")
            ],
            default: "true",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "launchanim",
            title: "App Launch Animation",
            summary: "Show bouncing animation when launching apps",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable launch animation", detail: "App icon bounces on launch"),
                DefaultsOption(value: "false", label: "Disable launch animation", detail: "Launch without bouncing animation")
            ],
            default: "true",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "static-only",
            title: "Show Only Static Dock Items",
            summary: "Show only persistent Dock items, hiding others",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Static only", detail: "Hide non-persistent items"),
                DefaultsOption(value: "false", label: "Normal behavior", detail: "Show all dock items")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        
        // MARK: Finder
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "AppleShowAllFiles",
            title: "Show Hidden Files",
            summary: "Show files and folders that begin with a dot (hidden files)",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show hidden files", detail: "Reveal all hidden files and folders"),
                DefaultsOption(value: "false", label: "Hide hidden files", detail: "Keep hidden files invisible")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "FXShowAllFileExtensions",
            title: "Show All File Extensions",
            summary: "Always show filename extensions in Finder",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Always show extensions", detail: "Display all file extensions"),
                DefaultsOption(value: "false", label: "Use per-file setting", detail: "Follow individual file extension visibility")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "FXPreferredViewStyle",
            title: "Default Finder View",
            summary: "Set the default view style for Finder windows",
            type: .enumType,
            options: [
                DefaultsOption(value: "Nlsv", label: "List View", detail: "Show files in a detailed list"),
                DefaultsOption(value: "clmv", label: "Column View", detail: "Navigate with columns"),
                DefaultsOption(value: "icnv", label: "Icon View", detail: "Large icon grid"),
                DefaultsOption(value: "glyv", label: "Gallery View", detail: "Visual gallery preview")
            ],
            default: "Nlsv",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "FXDefaultSearchScope",
            title: "Default Search Scope",
            summary: "Set what Finder searches by default",
            type: .enumType,
            options: [
                DefaultsOption(value: "SCcf", label: "This Mac", detail: "Search entire Mac by default"),
                DefaultsOption(value: "SCev", label: "Current Folder", detail: "Search only current folder by default")
            ],
            default: nil,
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "QLEnableTextSelection",
            title: "Quick Look Text Selection",
            summary: "Allow text selection in Quick Look previews",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable text selection", detail: "Select and copy text from Quick Look"),
                DefaultsOption(value: "false", label: "Disable text selection", detail: "No text selection in Quick Look")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "_FXSortFoldersFirst",
            title: "Sort Folders First",
            summary: "Keep folders at the top when sorting by name",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Folders first", detail: "Display folders before files"),
                DefaultsOption(value: "false", label: "Mixed sorting", detail: "Sort files and folders together")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "ShowExternalHardDrivesOnDesktop",
            title: "Show External Drives on Desktop",
            summary: "Display external hard drives as icons on the desktop",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show external drives", detail: "External drives appear on Desktop"),
                DefaultsOption(value: "false", label: "Hide external drives", detail: "Hide external drives from Desktop")
            ],
            default: "true",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "ShowHardDrivesOnDesktop",
            title: "Show Internal Drives on Desktop",
            summary: "Display internal hard drives as icons on the desktop",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show internal drives", detail: "Internal drives appear on Desktop"),
                DefaultsOption(value: "false", label: "Hide internal drives", detail: "Hide internal drives from Desktop")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "ShowMountedServersOnDesktop",
            title: "Show Mounted Servers on Desktop",
            summary: "Display mounted network servers as icons on the desktop",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show servers", detail: "Network servers appear on Desktop"),
                DefaultsOption(value: "false", label: "Hide servers", detail: "Hide servers from Desktop")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "ShowRemovableMediaOnDesktop",
            title: "Show Removable Media on Desktop",
            summary: "Display CDs, DVDs, and removable media on the desktop",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show removable media", detail: "Removable media appear on Desktop"),
                DefaultsOption(value: "false", label: "Hide removable media", detail: "Hide removable media from Desktop")
            ],
            default: "true",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "NewWindowTarget",
            title: "New Finder Window Target",
            summary: "Set which location opens when creating a new Finder window",
            type: .enumType,
            options: [
                DefaultsOption(value: "PfHm", label: "Home Folder", detail: "Open to your home directory"),
                DefaultsOption(value: "PfCf", label: "Recents", detail: "Open to Recents"),
                DefaultsOption(value: "PfDk", label: "Desktop", detail: "Open to Desktop folder"),
                DefaultsOption(value: "PfVo", label: "Volumes/Computer", detail: "Open to Computer view")
            ],
            default: nil,
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "WarnOnEmptyTrash",
            title: "Warn Before Emptying Trash",
            summary: "Show a confirmation dialog when emptying the Trash",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show warning", detail: "Confirm before emptying Trash"),
                DefaultsOption(value: "false", label: "No warning", detail: "Empty Trash without confirmation")
            ],
            default: "true",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "EmptyTrashSecurely",
            title: "Empty Trash Securely",
            summary: "Overwrite deleted files when emptying Trash for extra security",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Secure empty", detail: "Permanently and securely erase files"),
                DefaultsOption(value: "false", label: "Normal empty", detail: "Standard Trash empty")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "ShowStatusBar",
            title: "Show Status Bar",
            summary: "Display the status bar at bottom of Finder windows",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show status bar", detail: "Display status info at bottom"),
                DefaultsOption(value: "false", label: "Hide status bar", detail: "Hide the Finder status bar")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "ShowPathbar",
            title: "Show Path Bar",
            summary: "Display the path bar at bottom showing folder hierarchy",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show path bar", detail: "Show folder path at bottom"),
                DefaultsOption(value: "false", label: "Hide path bar", detail: "Hide the Finder path bar")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "CreateDesktop",
            title: "Show Desktop Icons",
            summary: "Show or hide all icons on the desktop",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show desktop icons", detail: "Display files/folders on Desktop"),
                DefaultsOption(value: "false", label: "Hide desktop icons", detail: "Keep Desktop clean with no icons")
            ],
            default: "true",
            restartApplication: "Finder"
        ),
        
        // MARK: Safari
        DefaultsCommand(
            category: .safari,
            domain: "com.apple.Safari",
            key: "ShowFullURLInSmartSearchField",
            title: "Show Full URL in Address Bar",
            summary: "Display the complete URL instead of just the domain",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show full URL", detail: "Display complete webpage address"),
                DefaultsOption(value: "false", label: "Show simplified URL", detail: "Display domain/name only")
            ],
            default: "false",
            restartApplication: "Safari"
        ),
        DefaultsCommand(
            category: .safari,
            domain: "com.apple.Safari",
            key: "IncludeDevelopMenu",
            title: "Show Develop Menu",
            summary: "Enable Safari's developer tools menu",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show Develop menu", detail: "Add Develop menu to Safari"),
                DefaultsOption(value: "false", label: "Hide Develop menu", detail: "Standard Safari menu bar")
            ],
            default: "false",
            restartApplication: "Safari"
        ),
        DefaultsCommand(
            category: .safari,
            domain: "com.apple.Safari",
            key: "AutoOpenSafeDownloads",
            title: "Auto-Open Safe Downloads",
            summary: "Automatically open files Safari considers safe after download",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Auto-open safe files", detail: "Open trusted downloads automatically"),
                DefaultsOption(value: "false", label: "Manual open", detail: "Open downloaded files manually")
            ],
            default: "true",
            restartApplication: "Safari"
        ),
        
        // MARK: Mail
        DefaultsCommand(
            category: .mail,
            domain: "com.apple.mail",
            key: "PreferPlainText",
            title: "Compose in Plain Text",
            summary: "Always compose emails in plain text instead of rich text",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Plain text only", detail: "Send emails as plain text"),
                DefaultsOption(value: "false", label: "Rich text allowed", detail: "Allow formatting and fonts")
            ],
            default: "false",
            restartApplication: "Mail"
        ),
        
        // MARK: Mission Control & Spaces
        DefaultsCommand(
            category: .missionControl,
            domain: "com.apple.dock",
            key: "expose-group-by-app",
            title: "Group Windows by App in Mission Control",
            summary: "Show windows grouped by application in Mission Control",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Group by app", detail: "Consolidate windows per app"),
                DefaultsOption(value: "false", label: "Show all windows", detail: "Display all windows individually")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .missionControl,
            domain: "com.apple.spaces",
            key: "displays-have-separate-spaces",
            title: "Displays Have Separate Spaces",
            summary: "When enabled, each display gets its own set of Spaces (requires logout)",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Separate Spaces per display", detail: "Each monitor has independent Spaces"),
                DefaultsOption(value: "false", label: "Shared Spaces", detail: "Spaces span all displays")
            ],
            default: "true",
            restartApplication: "Log out"
        ),
        
        // MARK: Dashboard
        DefaultsCommand(
            category: .dashboard,
            domain: "com.apple.dashboard",
            key: "mcx-disabled",
            title: "Disable Dashboard",
            summary: "Completely disable the Dashboard feature",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Disable Dashboard", detail: "Turn off Dashboard entirely"),
                DefaultsOption(value: "false", label: "Enable Dashboard", detail: "Keep Dashboard available")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        
        // MARK: TextEdit
        DefaultsCommand(
            category: .textEdit,
            domain: "com.apple.TextEdit",
            key: "RichText",
            title: "Default to Rich Text",
            summary: "Set whether TextEdit opens new documents in Rich Text or Plain Text mode",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Rich text by default", detail: "New documents allow formatting"),
                DefaultsOption(value: "false", label: "Plain text by default", detail: "New documents are plain text only")
            ],
            default: "true",
            restartApplication: "TextEdit"
        ),
        
        // MARK: Disk Utility
        DefaultsCommand(
            category: .diskUtility,
            domain: "com.apple.DiskUtility",
            key: "DUDebugMenuEnabled",
            title: "Enable Debug Menu",
            summary: "Add a Debug menu to Disk Utility for advanced options",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show Debug menu", detail: "Enable advanced Disk Utility features"),
                DefaultsOption(value: "false", label: "Hide Debug menu", detail: "Standard Disk Utility interface")
            ],
            default: "false",
            restartApplication: "Disk Utility"
        ),
        
        // MARK: Software Update
        DefaultsCommand(
            category: .softwareUpdate,
            domain: "com.apple.SoftwareUpdate",
            key: "AutomaticCheckEnabled",
            title: "Automatic Update Checks",
            summary: "Automatically check for macOS and app updates",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable automatic checks", detail: "Check for updates regularly"),
                DefaultsOption(value: "false", label: "Disable automatic checks", detail: "Check for updates manually")
            ],
            default: "true",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .softwareUpdate,
            domain: "com.apple.SoftwareUpdate",
            key: "AutomaticDownload",
            title: "Automatic Update Downloads",
            summary: "Automatically download available updates in background",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Auto-download updates", detail: "Downloads updates without asking"),
                DefaultsOption(value: "false", label: "Manual download", detail: "Download updates manually")
            ],
            default: "true",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .softwareUpdate,
            domain: "com.apple.SoftwareUpdate",
            key: "AutomaticallyInstallMacOSUpdates",
            title: "Automatically Install macOS Updates",
            summary: "Automatically install macOS system updates",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Auto-install updates", detail: "Install updates automatically"),
                DefaultsOption(value: "false", label: "Manual install", detail: "Install updates manually")
            ],
            default: "false",
            restartApplication: nil
        ),
        
        // MARK: App Store
        DefaultsCommand(
            category: .appStore,
            domain: "com.apple.commerce",
            key: "AutoUpdate",
            title: "Automatic App Updates",
            summary: "Automatically update apps from the App Store",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Auto-update apps", detail: "Keep apps updated automatically"),
                DefaultsOption(value: "false", label: "Manual updates", detail: "Update apps manually")
            ],
            default: "true",
            restartApplication: nil
        ),
        
        // MARK: Terminal
        DefaultsCommand(
            category: .terminal,
            domain: "com.apple.Terminal",
            key: "FocusFollowsMouse",
            title: "Focus Follows Mouse",
            summary: "Make windows active when mouse cursor moves over them (focus follows mouse)",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Focus follows mouse", detail: "Window focus follows cursor"),
                DefaultsOption(value: "false", label: "Click to focus", detail: "Click window to focus")
            ],
            default: "false",
            restartApplication: "Terminal"
        ),
        
        // MARK: Xcode
        DefaultsCommand(
            category: .xcode,
            domain: "com.apple.dt.Xcode",
            key: "ShowBuildOperationDuration",
            title: "Show Build Operation Duration",
            summary: "Display how long builds take in Xcode",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show build duration", detail: "Display build timing in UI"),
                DefaultsOption(value: "false", label: "Hide build duration", detail: "Don't show build timing")
            ],
            default: "false",
            restartApplication: "Xcode"
        )
    ]
}