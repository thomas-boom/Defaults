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
            category: .mouse,
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
            category: .trackpad,
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
            restartApplication: "Finder",
            risk: "Overwrites deleted files so they can never be recovered. This option has also been removed from recent macOS versions."
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
            key: "expose-group-apps",
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
            key: "spans-displays",
            title: "Displays Have Separate Spaces",
            summary: "When enabled, each display gets its own set of Spaces (requires logout)",
            type: .bool,
            options: [
                DefaultsOption(value: "false", label: "Separate Spaces per display", detail: "Each monitor has independent Spaces"),
                DefaultsOption(value: "true", label: "Shared Spaces", detail: "Spaces span all displays")
            ],
            default: "false",
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
        ),
        
        // MARK: System (Global) — additional
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "NSAutomaticWindowAnimationsEnabled",
            title: "Window Open/Close Animations",
            summary: "Enable or disable the animation when windows open and close",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Animate windows", detail: "Default window animations"),
                DefaultsOption(value: "false", label: "No animations", detail: "Windows appear/disappear instantly")
            ],
            default: "true",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "NSNavPanelExpandedStateForSaveMode",
            title: "Expand Save Panel by Default",
            summary: "Open the full save dialog instead of the compact version",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Always expanded", detail: "Show the full save panel"),
                DefaultsOption(value: "false", label: "Compact", detail: "Use the collapsed save panel")
            ],
            default: "false",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "PMPrintingExpandedStateForPrint",
            title: "Expand Print Panel by Default",
            summary: "Show the full print dialog with all options expanded",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Always expanded", detail: "Show all print options"),
                DefaultsOption(value: "false", label: "Compact", detail: "Use the collapsed print panel")
            ],
            default: "false",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "AppleShowScrollBars",
            title: "When to Show Scroll Bars",
            summary: "Control whether scroll bars are always, never, or automatically shown",
            type: .enumType,
            options: [
                DefaultsOption(value: "Automatic", label: "Automatically", detail: "Based on the input device"),
                DefaultsOption(value: "WhenScrolling", label: "When scrolling", detail: "Only while scrolling"),
                DefaultsOption(value: "Always", label: "Always", detail: "Scroll bars always visible")
            ],
            default: "Automatic",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "AppleEnableSwipeNavigateWithScrolls",
            title: "Swipe Between Pages",
            summary: "Swipe with two fingers to move forward or back in apps and Safari",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable two-finger swipe", detail: "Swipe to navigate pages"),
                DefaultsOption(value: "false", label: "Disable swipe", detail: "Turn off swipe navigation")
            ],
            default: "true",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "NSQuitAlwaysKeepsWindows",
            title: "Restore Windows on Reopen",
            summary: "Reopen windows and documents when a app is relaunched",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Restore windows", detail: "Keep windows on restart"),
                DefaultsOption(value: "false", label: "Start fresh", detail: "Don't restore previous windows")
            ],
            default: "true",
            restartApplication: "Relaunch apps",
            risk: "Disabling this makes macOS forget open windows and documents, which some apps rely on to restore work."
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "NSDisableAutomaticTermination",
            title: "Disable Automatic App Termination",
            summary: "Prevent macOS from quitting apps to free up memory",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Never auto-quit", detail: "Apps stay open in memory"),
                DefaultsOption(value: "false", label: "Allow auto-quit", detail: "macOS may quit idle apps")
            ],
            default: "false",
            restartApplication: nil
        ),
        
        // MARK: Keyboard
        DefaultsCommand(
            category: .keyboard,
            domain: "com.apple.HIToolbox",
            key: "AppleFnUsageType",
            title: "Function Key Behavior",
            summary: "Choose what happens when you press the globe/fn key",
            type: .int,
            options: [
                DefaultsOption(value: "0", label: "Do Nothing", detail: "fn key has no special action"),
                DefaultsOption(value: "1", label: "Change Input Source", detail: "Switch keyboard input source"),
                DefaultsOption(value: "2", label: "Show Emoji & Symbols", detail: "Open the character viewer"),
                DefaultsOption(value: "3", label: "Start Dictation", detail: "Begin dictation")
            ],
            default: "0",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .keyboard,
            domain: "-g",
            key: "AppleKeyboardUIMode",
            title: "Full Keyboard Access",
            summary: "Tab through all controls, not just text fields",
            type: .int,
            options: [
                DefaultsOption(value: "0", label: "Text fields only", detail: "Tab moves between text fields"),
                DefaultsOption(value: "2", label: "All controls", detail: "Tab reaches buttons and lists"),
                DefaultsOption(value: "3", label: "All controls + lists", detail: "Full keyboard navigation")
            ],
            default: "0",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .keyboard,
            domain: "-g",
            key: "com.apple.keyboard.fnState",
            title: "Use F1–F12 as Standard Function Keys",
            summary: "Make the top row send F1–F12 instead of the media shortcuts",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Standard function keys", detail: "Top row sends F1–F12"),
                DefaultsOption(value: "false", label: "Media keys", detail: "Top row controls brightness/volume")
            ],
            default: "false",
            restartApplication: nil
        ),
        
        // MARK: Login Window
        DefaultsCommand(
            category: .loginWindow,
            domain: "com.apple.loginwindow",
            key: "SHOWFULLNAME",
            title: "Show Name and Password Fields",
            summary: "Display separate name and password fields instead of a list of users",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Name & password fields", detail: "Type your account name"),
                DefaultsOption(value: "false", label: "User list", detail: "Click your user picture")
            ],
            default: "false",
            restartApplication: "Log out"
        ),
        DefaultsCommand(
            category: .loginWindow,
            domain: "com.apple.loginwindow",
            key: "DisableGuestAccount",
            title: "Disable Guest Account",
            summary: "Stop the Guest User account from being available at login",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Disable guest", detail: "No guest login allowed"),
                DefaultsOption(value: "false", label: "Enable guest", detail: "Allow guest login")
            ],
            default: "false",
            restartApplication: "Log out",
            risk: "If FileVault is enabled, enabling a guest account can grant disk access without a password. Disabling it is the safer choice."
        ),
        DefaultsCommand(
            category: .loginWindow,
            domain: "com.apple.loginwindow",
            key: "TALLogoutSavesState",
            title: "Resume Apps After Log In",
            summary: "Reopen apps and windows when you log back in",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Resume", detail: "Reopen apps on login"),
                DefaultsOption(value: "false", label: "Start fresh", detail: "Don't reopen apps")
            ],
            default: "true",
            restartApplication: "Log out"
        ),
        DefaultsCommand(
            category: .loginWindow,
            domain: "com.apple.loginwindow",
            key: "LoginwindowText",
            title: "Login Screen Message",
            summary: "Display a custom message (ownership notice) on the login screen",
            type: .string,
            options: [
                DefaultsOption(value: "This Mac belongs to Thomas", label: "Example: ownership notice", detail: "Shown on the login window"),
                DefaultsOption(value: "Authorized users only", label: "Example: warning", detail: "A short warning message")
            ],
            default: nil,
            restartApplication: "Log out"
        ),
        
        // MARK: Screensaver
        DefaultsCommand(
            category: .screensaver,
            domain: "com.apple.screensaver",
            key: "askForPassword",
            title: "Require Password After Screensaver",
            summary: "Require a password when waking from the screensaver",
            type: .int,
            options: [
                DefaultsOption(value: "1", label: "Require password", detail: "Ask for password on wake"),
                DefaultsOption(value: "0", label: "No password", detail: "Wake without a password")
            ],
            default: "1",
            restartApplication: nil,
            risk: "Turning this off leaves your Mac accessible to anyone who wakes it."
        ),
        DefaultsCommand(
            category: .screensaver,
            domain: "com.apple.screensaver",
            key: "askForPasswordDelay",
            title: "Password Grace Period",
            summary: "Delay (in seconds) before the password is required",
            type: .int,
            options: [
                DefaultsOption(value: "0", label: "Immediately", detail: "Lock right away"),
                DefaultsOption(value: "5", label: "5 seconds", detail: "Short grace period"),
                DefaultsOption(value: "60", label: "1 minute", detail: "One minute grace period"),
                DefaultsOption(value: "300", label: "5 minutes", detail: "Longer grace period")
            ],
            default: "0",
            restartApplication: nil,
            risk: "A long grace period means your Mac stays unlocked for that time after the screensaver starts."
        ),
        DefaultsCommand(
            category: .screensaver,
            domain: "com.apple.screensaver",
            key: "idleTime",
            title: "Screensaver Idle Delay",
            summary: "Seconds of inactivity before the screensaver starts",
            type: .int,
            options: [
                DefaultsOption(value: "300", label: "5 minutes", detail: "Start after 5 minutes"),
                DefaultsOption(value: "600", label: "10 minutes", detail: "Start after 10 minutes"),
                DefaultsOption(value: "1200", label: "20 minutes", detail: "Start after 20 minutes"),
                DefaultsOption(value: "0", label: "Never", detail: "Disable the screensaver")
            ],
            default: "1200",
            restartApplication: nil
        ),
        
        // MARK: AirDrop
        DefaultsCommand(
            category: .airDrop,
            domain: "com.apple.NetworkBrowser",
            key: "BrowseAllInterfaces",
            title: "Use AirDrop on All Network Interfaces",
            summary: "Make AirDrop discoverable over Ethernet and other interfaces, not just Wi-Fi",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "All interfaces", detail: "AirDrop works on any network"),
                DefaultsOption(value: "false", label: "Wi-Fi only", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .airDrop,
            domain: "com.apple.NetworkBrowser",
            key: "DisableAirDrop",
            title: "Disable AirDrop",
            summary: "Completely turn off AirDrop",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Disable AirDrop", detail: "Hides AirDrop everywhere"),
                DefaultsOption(value: "false", label: "Enable AirDrop", detail: "Keep AirDrop available")
            ],
            default: "false",
            restartApplication: "Finder",
            risk: "Disables AirDrop for the whole system. The change is reversible but not obvious in the UI."
        ),
        
        // MARK: Crash Reporter
        DefaultsCommand(
            category: .crashReporter,
            domain: "com.apple.CrashReporter",
            key: "DialogType",
            title: "Crash Report Prompt",
            summary: "Control what happens when an app crashes",
            type: .enumType,
            options: [
                DefaultsOption(value: "crashreport", label: "Show prompt", detail: "Ask before sending a report"),
                DefaultsOption(value: "server", label: "Send automatically", detail: "Silently send reports"),
                DefaultsOption(value: "none", label: "Do nothing", detail: "Hide crash dialogs entirely")
            ],
            default: "crashreport",
            restartApplication: nil,
            risk: "\"Do nothing\" hides all crash dialogs and can make app problems much harder to diagnose."
        ),
        
        // MARK: .DS_Store
        DefaultsCommand(
            category: .dsStore,
            domain: "com.apple.desktopservices",
            key: "DSDontWriteNetworkStores",
            title: "Don't Create .DS_Store on Network Drives",
            summary: "Stop Finder from writing .DS_Store files onto network volumes",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Don't write", detail: "No .DS_Store on network drives"),
                DefaultsOption(value: "false", label: "Write normally", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .dsStore,
            domain: "com.apple.desktopservices",
            key: "DSDontWriteUSBStores",
            title: "Don't Create .DS_Store on USB Drives",
            summary: "Stop Finder from writing .DS_Store files onto USB/removable volumes",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Don't write", detail: "No .DS_Store on USB drives"),
                DefaultsOption(value: "false", label: "Write normally", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        
        // MARK: Screenshots
        DefaultsCommand(
            category: .screenshots,
            domain: "com.apple.screencapture",
            key: "location",
            title: "Screenshot Save Location",
            summary: "Where screenshots are saved",
            type: .string,
            options: [
                DefaultsOption(value: "~/Desktop", label: "Desktop", detail: "Save to the Desktop"),
                DefaultsOption(value: "~/Downloads", label: "Downloads", detail: "Save to Downloads"),
                DefaultsOption(value: "~/Documents", label: "Documents", detail: "Save to Documents"),
                DefaultsOption(value: "~/Pictures/Screenshots", label: "Pictures/Screenshots", detail: "Dedicated screenshots folder")
            ],
            default: "~/Desktop",
            restartApplication: "SystemUIServer"
        ),
        DefaultsCommand(
            category: .menuBarClock,
            domain: "com.apple.menuextra.clock",
            key: "FlashDateSeparators",
            title: "Flash Date Separators",
            summary: "Flash the colon in the menu bar clock",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Flash", detail: "Colons blink"),
                DefaultsOption(value: "false", label: "Don't flash", detail: "Static colons")
            ],
            default: "false",
            restartApplication: "SystemUIServer"
        ),
        DefaultsCommand(
            category: .screenshots,
            domain: "com.apple.screencapture",
            key: "include-date",
            title: "Include Date in Filename",
            summary: "Include the current date in screenshot filenames",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Include date", detail: "Add date to filename"),
                DefaultsOption(value: "false", label: "Omit date", detail: "Default naming")
            ],
            default: "true",
            restartApplication: "SystemUIServer"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "AppleInterfaceStyleSwitchesAutomatically",
            title: "Auto Switch to Dark Mode",
            summary: "Automatically toggle between light and dark appearance",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Auto-switch", detail: "Follow schedule"),
                DefaultsOption(value: "false", label: "Manual", detail: "Fixed appearance")
            ],
            default: "false",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "AppleReduceMotion",
            title: "Reduce Motion",
            summary: "Minimize motion effects throughout the system",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Reduce motion", detail: "Fewer animations"),
                DefaultsOption(value: "false", label: "Full motion", detail: "Default animations")
            ],
            default: "false",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "AppleReduceTransparency",
            title: "Reduce Transparency",
            summary: "Increase contrast by reducing transparency effects",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Reduce transparency", detail: "More opaque UI"),
                DefaultsOption(value: "false", label: "Full transparency", detail: "Default effect")
            ],
            default: "false",
            restartApplication: "Relaunch apps"
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "CGFontRenderingFontSmoothingDisabled",
            title: "Disable Font Smoothing",
            summary: "Turn off subpixel font rendering (antialiasing)",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Disabled", detail: "Sharper text in some cases"),
                DefaultsOption(value: "false", label: "Enabled", detail: "Default smoothing")
            ],
            default: "false",
            restartApplication: "Relaunch apps",
            risk: "May affect text clarity; generally not recommended."
        ),
        DefaultsCommand(
            category: .safari,
            domain: "com.apple.Safari",
            key: "WebKitDeveloperExtrasEnabled",
            title: "Safari Developer Extras (WebKit1)",
            summary: "Enable developer tools for Safari's WebKit engine",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable", detail: "Show Develop menu extras"),
                DefaultsOption(value: "false", label: "Disable", detail: "Default")
            ],
            default: "false",
            restartApplication: "Safari"
        ),
        DefaultsCommand(
            category: .safari,
            domain: "com.apple.Safari",
            key: "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled",
            title: "Safari Developer Extras (WebKit2)",
            summary: "Enable developer extras for WebKit2 processes",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable", detail: "Enable WebKit2 dev extras"),
                DefaultsOption(value: "false", label: "Disable", detail: "Default")
            ],
            default: "false",
            restartApplication: "Safari"
        ),
        DefaultsCommand(
            category: .screenshots,
            domain: "com.apple.screencapture",
            key: "type",
            title: "Screenshot File Format",
            summary: "Image format used for screenshots",
            type: .enumType,
            options: [
                DefaultsOption(value: "png", label: "PNG", detail: "Lossless, larger files"),
                DefaultsOption(value: "jpg", label: "JPEG", detail: "Smaller, lossy files"),
                DefaultsOption(value: "pdf", label: "PDF", detail: "Vector-friendly format"),
                DefaultsOption(value: "tiff", label: "TIFF", detail: "Uncompressed format")
            ],
            default: "png",
            restartApplication: "SystemUIServer"
        ),
        DefaultsCommand(
            category: .screenshots,
            domain: "com.apple.screencapture",
            key: "disable-shadow",
            title: "Window Screenshot Shadow",
            summary: "Whether screenshots of windows include a drop shadow",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "No shadow", detail: "Omit the drop shadow"),
                DefaultsOption(value: "false", label: "Include shadow", detail: "Keep the shadow")
            ],
            default: "false",
            restartApplication: "SystemUIServer"
        ),
        DefaultsCommand(
            category: .screenshots,
            domain: "com.apple.screencapture",
            key: "show-thumbnail",
            title: "Show Floating Thumbnail",
            summary: "Show the floating preview thumbnail after taking a screenshot",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show thumbnail", detail: "Floating preview appears"),
                DefaultsOption(value: "false", label: "Hide thumbnail", detail: "Screenshot saves silently")
            ],
            default: "true",
            restartApplication: "SystemUIServer"
        ),
        
        // MARK: Menu Bar Clock
        DefaultsCommand(
            category: .menuBarClock,
            domain: "com.apple.menuextra.clock",
            key: "ShowSeconds",
            title: "Show Seconds in Clock",
            summary: "Display seconds in the menu bar clock",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show seconds", detail: "Clock shows hh:mm:ss"),
                DefaultsOption(value: "false", label: "Hide seconds", detail: "Clock shows hh:mm")
            ],
            default: "false",
            restartApplication: "SystemUIServer"
        ),
        DefaultsCommand(
            category: .menuBarClock,
            domain: "com.apple.menuextra.clock",
            key: "ShowDayOfWeek",
            title: "Show Day of Week",
            summary: "Include the weekday in the menu bar clock",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show weekday", detail: "e.g. Mon 09:41"),
                DefaultsOption(value: "false", label: "Hide weekday", detail: "e.g. 09:41")
            ],
            default: "false",
            restartApplication: "SystemUIServer"
        ),
        DefaultsCommand(
            category: .menuBarClock,
            domain: "com.apple.menuextra.clock",
            key: "IsAnalog",
            title: "Analog Menu Bar Clock",
            summary: "Show an analog clock in the menu bar",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Analog clock", detail: "Show a clock face"),
                DefaultsOption(value: "false", label: "Digital clock", detail: "Show text time")
            ],
            default: "false",
            restartApplication: "SystemUIServer"
        ),
        DefaultsCommand(
            category: .menuBarClock,
            domain: "com.apple.menuextra.clock",
            key: "DateFormat",
            title: "Menu Bar Date Format",
            summary: "Custom date/time format string for the menu bar clock",
            type: .string,
            options: [
                DefaultsOption(value: "EEE d MMM  HH:mm", label: "Weekday D Mon HH:mm", detail: "e.g. Mon 18 Oct  14:05"),
                DefaultsOption(value: "EEE d MMM  h:mm a", label: "Weekday D Mon h:mm AM/PM", detail: "12-hour format"),
                DefaultsOption(value: "EEE HH:mm:ss", label: "Weekday HH:mm:ss", detail: "With seconds")
            ],
            default: nil,
            restartApplication: "SystemUIServer"
        ),
        
        // MARK: Finder — additional
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "_FXShowPosixPathInTitle",
            title: "Show Full Path in Finder Title",
            summary: "Display the full POSIX path in the title bar of Finder windows",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show full path", detail: "e.g. /Users/you/Documents"),
                DefaultsOption(value: "false", label: "Show folder name", detail: "Just the folder name")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "FXEnableExtensionChangeWarning",
            title: "Warn Before Changing a File Extension",
            summary: "Show a warning when you change a file's extension",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show warning", detail: "Confirm extension changes"),
                DefaultsOption(value: "false", label: "No warning", detail: "Change extensions silently")
            ],
            default: "true",
            restartApplication: "Finder",
            risk: "Disabling the warning lets you change an extension with no confirmation, which can make files impossible to open."
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "DisableAllAnimations",
            title: "Disable Finder Animations",
            summary: "Turn off animations in Finder windows for a snappier feel",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "No animations", detail: "Instant window changes"),
                DefaultsOption(value: "false", label: "Keep animations", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        
        // MARK: Dashboard / Mission Control — additional
        DefaultsCommand(
            category: .missionControl,
            domain: "com.apple.dock",
            key: "mru-spaces",
            title: "Automatically Rearrange Spaces",
            summary: "Reorder Spaces based on how recently they were used",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Auto-rearrange", detail: "Most recent Space first"),
                DefaultsOption(value: "false", label: "Keep order", detail: "Spaces never move")
            ],
            default: "true",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .missionControl,
            domain: "com.apple.dock",
            key: "expose-animation-duration",
            title: "Mission Control Animation Speed",
            summary: "Duration of the Mission Control animation",
            type: .float,
            options: [
                DefaultsOption(value: "0.0", label: "Instant", detail: "No animation"),
                DefaultsOption(value: "0.1", label: "Fast", detail: "Quick animation"),
                DefaultsOption(value: "0.5", label: "Slower", detail: "Longer animation")
            ],
            default: nil,
            restartApplication: "Dock"
        ),
        
        // MARK: Screenshot of Dock extras
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "no-glass",
            title: "Disable 3D Dock Glass",
            summary: "Use a flat, two-dimensional Dock instead of the glass effect",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Flat Dock", detail: "No glass/gradient effect"),
                DefaultsOption(value: "false", label: "Glass Dock", detail: "Default 3D look")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "showhidden",
            title: "Show Hidden Dock Items",
            summary: "Make hidden (transparent) Dock icons visible",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show hidden items", detail: "Reveal transparent icons"),
                DefaultsOption(value: "false", label: "Hide them", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        
        // MARK: Mouse
        DefaultsCommand(
            category: .mouse,
            domain: "com.apple.Terminal",
            key: "FocusFollowsMouse",
            title: "Focus Follows Mouse",
            summary: "Focus Terminal windows when the mouse cursor hovers over them (only works between Terminal windows)",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Focus follows mouse", detail: "Terminal window focus follows the cursor"),
                DefaultsOption(value: "false", label: "Click to focus", detail: "Click a Terminal window to focus it")
            ],
            default: "false",
            restartApplication: "Terminal"
        ),
        DefaultsCommand(
            category: .mouse,
            domain: "-g",
            key: "com.apple.mouse.linear",
            title: "Disable Mouse Acceleration",
            summary: "Turn off pointer acceleration so the cursor moves at a constant rate",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Linear (no acceleration)", detail: "Constant pointer speed"),
                DefaultsOption(value: "false", label: "Accelerated", detail: "Default macOS acceleration")
            ],
            default: "false",
            restartApplication: nil
        ),
        
        // MARK: Trackpad
        DefaultsCommand(
            category: .trackpad,
            domain: "com.apple.AppleMultitouchTrackpad",
            key: "Dragging",
            title: "Dragging",
            summary: "Tap and drag with one finger without holding the trackpad button",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable dragging", detail: "Double-tap and drag"),
                DefaultsOption(value: "false", label: "Off", detail: "Use the trackpad button or a click")
            ],
            default: "false",
            restartApplication: nil,
            risk: "Mutually exclusive with Drag Lock and three-finger drag; enabling one disables the others."
        ),
        DefaultsCommand(
            category: .trackpad,
            domain: "com.apple.AppleMultitouchTrackpad",
            key: "DragLock",
            title: "Dragging with Drag Lock",
            summary: "Keep dragging after you lift your finger, until you tap again",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Drag lock", detail: "Stay in drag mode after lifting"),
                DefaultsOption(value: "false", label: "Off", detail: "Stop dragging when you lift")
            ],
            default: "false",
            restartApplication: nil,
            risk: "Mutually exclusive with Dragging and three-finger drag."
        ),
        DefaultsCommand(
            category: .trackpad,
            domain: "com.apple.AppleMultitouchTrackpad",
            key: "TrackpadThreeFingerDrag",
            title: "Dragging with Three Fingers",
            summary: "Move the pointer and drag using three fingers",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Three-finger drag", detail: "Drag with three fingers"),
                DefaultsOption(value: "false", label: "Off", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: nil,
            risk: "Mutually exclusive with Dragging and Drag Lock."
        ),
        DefaultsCommand(
            category: .trackpad,
            domain: "com.apple.AppleMultitouchTrackpad",
            key: "FirstClickThreshold",
            title: "Click Weight (Threshold)",
            summary: "How firmly you must press for the trackpad to register a click",
            type: .int,
            options: [
                DefaultsOption(value: "0", label: "Light", detail: "Lightest click force"),
                DefaultsOption(value: "1", label: "Medium", detail: "Default click force"),
                DefaultsOption(value: "2", label: "Firm", detail: "Harder click force")
            ],
            default: "1",
            restartApplication: nil
        ),
        
        // MARK: Activity Monitor
        DefaultsCommand(
            category: .activityMonitor,
            domain: "com.apple.ActivityMonitor",
            key: "UpdatePeriod",
            title: "Update Frequency",
            summary: "How often Activity Monitor refreshes its data, in seconds",
            type: .int,
            options: [
                DefaultsOption(value: "1", label: "1 second", detail: "Update every second"),
                DefaultsOption(value: "2", label: "2 seconds", detail: "Update every 2 seconds"),
                DefaultsOption(value: "5", label: "5 seconds", detail: "Update every 5 seconds")
            ],
            default: "5",
            restartApplication: "Activity Monitor"
        ),
        DefaultsCommand(
            category: .activityMonitor,
            domain: "com.apple.ActivityMonitor",
            key: "IconType",
            title: "Dock Icon Type",
            summary: "Choose what the Activity Monitor Dock icon shows",
            type: .int,
            options: [
                DefaultsOption(value: "0", label: "Application icon", detail: "Standard app icon"),
                DefaultsOption(value: "2", label: "CPU usage", detail: "Live CPU graph"),
                DefaultsOption(value: "3", label: "CPU history", detail: "CPU usage over time"),
                DefaultsOption(value: "5", label: "Network usage", detail: "Live network graph"),
                DefaultsOption(value: "6", label: "Disk activity", detail: "Live disk activity graph")
            ],
            default: "0",
            restartApplication: "Activity Monitor"
        ),
        
        // MARK: Simulator
        DefaultsCommand(
            category: .simulator,
            domain: "com.apple.iphonesimulator",
            key: "ScreenShotSaveLocation",
            title: "Screenshot Location",
            summary: "Folder where Simulator screenshots are saved (the folder must already exist)",
            type: .string,
            options: [
                DefaultsOption(value: "~/Pictures/Screenshots", label: "~/Pictures/Screenshots", detail: "Shared screenshots folder"),
                DefaultsOption(value: "~/Pictures/Simulator Screenshots", label: "~/Pictures/Simulator Screenshots", detail: "Dedicated Simulator folder")
            ],
            default: nil,
            restartApplication: "Simulator"
        ),
        
        // MARK: Messages
        DefaultsCommand(
            category: .messages,
            domain: "com.apple.MobileSMS",
            key: "MMSShowSubject",
            title: "Show Subject Field",
            summary: "Show a subject field above the message field in Messages",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show subject field", detail: "Display the subject line"),
                DefaultsOption(value: "false", label: "Hide subject field", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Messages"
        ),
        
        // MARK: Music
        DefaultsCommand(
            category: .music,
            domain: "com.apple.Music",
            key: "userWantsPlaybackNotifications",
            title: "Song Change Notifications",
            summary: "Show a notification when a new song starts playing in Music",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show notifications", detail: "Notify on each new song"),
                DefaultsOption(value: "false", label: "Don't notify", detail: "Silent track changes")
            ],
            default: "true",
            restartApplication: "Music"
        ),
        
        // MARK: TextEdit — additional
        DefaultsCommand(
            category: .textEdit,
            domain: "com.apple.TextEdit",
            key: "SmartQuotes",
            title: "Smart Quotes",
            summary: "Automatically convert straight quotation marks to typographic quotes",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Smart quotes", detail: "Use curly quotes"),
                DefaultsOption(value: "false", label: "Straight quotes", detail: "Use straight quotes")
            ],
            default: "true",
            restartApplication: "TextEdit"
        ),
        
        // MARK: Xcode — additional
        DefaultsCommand(
            category: .xcode,
            domain: "com.apple.dt.Xcode",
            key: "IDEAdditionalCounterpartSuffixes",
            title: "Additional Counterpart Suffixes",
            summary: "Add extra suffixes that Xcode treats as counterparts in the Related Items menu",
            type: .array,
            options: [
                DefaultsOption(value: "\"ViewModel\" \"View\"", label: "ViewModel / View", detail: "Adds -ViewModel and -View"),
                DefaultsOption(value: "\"Router\" \"Interactor\" \"Builder\"", label: "Router / Interactor / Builder", detail: "Adds -Router, -Interactor and -Builder")
            ],
            default: nil,
            restartApplication: "Xcode"
        ),
        
        // MARK: Time Machine
        DefaultsCommand(
            category: .timeMachine,
            domain: "com.apple.TimeMachine",
            key: "DoNotOfferNewDisksForBackup",
            title: "Don't Offer New Disks",
            summary: "Stop Time Machine prompting to use newly connected drives as backup disks",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Don't offer new disks", detail: "Never prompt"),
                DefaultsOption(value: "false", label: "Offer new disks", detail: "Prompt when a disk is connected")
            ],
            default: "false",
            restartApplication: nil
        ),
        
        // MARK: Feedback Assistant
        DefaultsCommand(
            category: .feedbackAssistant,
            domain: "com.apple.appleseed.FeedbackAssistant",
            key: "Autogather",
            title: "Autogather",
            summary: "Automatically collect large diagnostic files when submitting a feedback report",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Autogather", detail: "Collect diagnostics automatically"),
                DefaultsOption(value: "false", label: "Don't autogather", detail: "Attach files manually")
            ],
            default: "true",
            restartApplication: nil
        ),
        
        // MARK: Dock — additional
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "scroll-to-open",
            title: "Scroll to Exposé",
            summary: "Scroll up on a Dock icon to show that app's windows, or to open a stack",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable scroll to Exposé", detail: "Scroll on an icon to show its windows"),
                DefaultsOption(value: "false", label: "Disable", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        DefaultsCommand(
            category: .dock,
            domain: "com.apple.dock",
            key: "enable-spring-load-actions-on-all-items",
            title: "Spring Loading for All Dock Items",
            summary: "Hover a dragged file over any Dock icon to open it in that app",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable spring loading", detail: "Hover over any Dock icon"),
                DefaultsOption(value: "false", label: "Disable", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Dock"
        ),
        
        // MARK: Finder — imported from macOS defaults
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "_FXSortFoldersFirstOnDesktop",
            title: "Keep Folders on Top of Desktop",
            summary: "Sort desktop icons so folders always appear before files",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Folders on top", detail: "Group folders above files"),
                DefaultsOption(value: "false", label: "Sort by name", detail: "Default ordering")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "_FXEnableColumnAutoSizing",
            title: "Column Auto Sizing",
            summary: "Automatically widen columns in column view to fit their contents",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Auto size columns", detail: "Fit content automatically"),
                DefaultsOption(value: "false", label: "Fixed width", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "FinderSpawnTab",
            title: "Open Folders in Tabs",
            summary: "Open Finder folders in a new tab instead of a new window",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "New tab", detail: "Open folders in tabs"),
                DefaultsOption(value: "false", label: "New window", detail: "Open folders in windows")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "FXRemoveOldTrashItems",
            title: "Empty Trash After 30 Days",
            summary: "Automatically delete items that have been in the Trash for more than 30 days",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Remove after 30 days", detail: "Trash empties automatically"),
                DefaultsOption(value: "false", label: "Keep items", detail: "Keep the Trash until emptied manually")
            ],
            default: "false",
            restartApplication: "Finder",
            risk: "Files left in the Trash are deleted permanently after 30 days and cannot be recovered."
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.finder",
            key: "QuitMenuItem",
            title: "Quit Menu Item",
            summary: "Add a Quit command to the Finder menu",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show Quit", detail: "Add Quit to the Finder menu"),
                DefaultsOption(value: "false", label: "Hide Quit", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Finder",
            risk: "Quitting Finder behaves oddly and can leave the desktop without a running Finder session."
        ),
        DefaultsCommand(
            category: .finder,
            domain: "com.apple.universalaccess",
            key: "showWindowTitlebarIcons",
            title: "Title Bar Icons",
            summary: "Always show the folder icon before the title in window title bars",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Always show icon", detail: "Show the title bar icon"),
                DefaultsOption(value: "false", label: "Hide icon", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "-g",
            key: "NSDocumentsSaveNewDocumentsToCloud",
            title: "Save to Disk Location",
            summary: "Choose whether new documents are saved to iCloud Drive or to a local folder",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Save to iCloud Drive", detail: "Default cloud location"),
                DefaultsOption(value: "false", label: "Save on this Mac", detail: "Use a local folder")
            ],
            default: "true",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .finder,
            domain: "-g",
            key: "NSTableViewDefaultSizeMode",
            title: "Sidebar Icon Size",
            summary: "Choose the size of icons in Finder and other app sidebars",
            type: .int,
            options: [
                DefaultsOption(value: "1", label: "Small", detail: "Compact sidebar icons"),
                DefaultsOption(value: "2", label: "Medium", detail: "Default sidebar icon size"),
                DefaultsOption(value: "3", label: "Large", detail: "Large sidebar icons")
            ],
            default: "2",
            restartApplication: "Finder"
        ),
        DefaultsCommand(
            category: .finder,
            domain: "-g",
            key: "NSToolbarTitleViewRolloverDelay",
            title: "Toolbar Title Rollover Delay",
            summary: "How long to hover over a window title before the hidden icon appears",
            type: .float,
            options: [
                DefaultsOption(value: "0", label: "Instant", detail: "No delay"),
                DefaultsOption(value: "0.5", label: "0.5 s", detail: "Short delay"),
                DefaultsOption(value: "1", label: "1 s", detail: "Longer delay")
            ],
            default: nil,
            restartApplication: "Finder"
        ),
        
        // MARK: Keyboard — additional
        DefaultsCommand(
            category: .keyboard,
            domain: "-g",
            key: "NSAutomaticPeriodSubstitutionEnabled",
            title: "Add Period With Double Space",
            summary: "Type a period by pressing the space bar twice",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Enable", detail: "Double-space inserts a period"),
                DefaultsOption(value: "false", label: "Disable", detail: "Double-space inserts two spaces")
            ],
            default: "true",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .keyboard,
            domain: "-g",
            key: "TSMLanguageIndicatorEnabled",
            title: "Toggle Language Indicator",
            summary: "Show the language indicator while switching input sources",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show indicator", detail: "Display the language indicator"),
                DefaultsOption(value: "false", label: "Hide indicator", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: nil
        ),
        
        // MARK: Mission Control — additional
        DefaultsCommand(
            category: .missionControl,
            domain: "-g",
            key: "AppleSpacesSwitchOnActivate",
            title: "Switch to Space With Open Windows",
            summary: "When you switch to an app, jump to a Space that already has its windows",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Switch Spaces", detail: "Move to a Space with the app's windows"),
                DefaultsOption(value: "false", label: "Stay put", detail: "Stay on the current Space")
            ],
            default: "true",
            restartApplication: "Dock"
        ),
        
        // MARK: System — additional
        DefaultsCommand(
            category: .system,
            domain: "com.apple.helpviewer",
            key: "DevMode",
            title: "Help Menu Always on Top",
            summary: "Keep the Help menu pinned above other windows",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Always on top", detail: "Help menu stays visible"),
                DefaultsOption(value: "false", label: "Normal", detail: "Default behaviour")
            ],
            default: "false",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "com.apple.LaunchServices",
            key: "LSQuarantine",
            title: "App Quarantine Warning",
            summary: "Show the downloaded-from-the-Internet warning when opening a downloaded app",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Show warning", detail: "Warn about downloaded apps"),
                DefaultsOption(value: "false", label: "Disable warning", detail: "Open without the warning")
            ],
            default: "true",
            restartApplication: nil,
            risk: "Turning this off removes a safety check that warns you before opening downloaded apps."
        ),
        DefaultsCommand(
            category: .system,
            domain: "-g",
            key: "NSCloseAlwaysConfirmsChanges",
            title: "Always Confirm Closing Documents",
            summary: "Ask whether to keep changes when closing a document instead of saving automatically",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Always confirm", detail: "Ask before closing"),
                DefaultsOption(value: "false", label: "Save automatically", detail: "Don't ask")
            ],
            default: "false",
            restartApplication: nil
        ),
        DefaultsCommand(
            category: .system,
            domain: "com.apple.CloudSubscriptionFeatures.optIn",
            key: "545129924",
            title: "Apple Intelligence Opt-In",
            summary: "Toggle the Apple Intelligence opt-in flag from the command line",
            type: .bool,
            options: [
                DefaultsOption(value: "true", label: "Opt in", detail: "Enable the Apple Intelligence opt-in"),
                DefaultsOption(value: "false", label: "Opt out", detail: "Disable the Apple Intelligence opt-in")
            ],
            default: nil,
            restartApplication: nil,
            risk: "This uses an undocumented, version-specific key. It may have no effect or stop working after a macOS update."
        )
    ]
}