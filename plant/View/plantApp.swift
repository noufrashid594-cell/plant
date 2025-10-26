import SwiftUI

@main
struct plantApp: App {
    @StateObject private var plantViewModel = PlantViewModel()

    var body: some Scene {
        WindowGroup {
            MainPage()
                .environmentObject(plantViewModel)
        }
    }
}
