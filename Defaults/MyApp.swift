import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                WindowBackdrop()
                ContentView()
            }
        }
        .defaultSize(width: AppMetrics.defaultWindowWidth, height: AppMetrics.defaultWindowHeight)
    }
}
