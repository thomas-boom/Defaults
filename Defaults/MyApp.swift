import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: AppMetrics.defaultWindowWidth, height: AppMetrics.defaultWindowHeight)
    }
}
