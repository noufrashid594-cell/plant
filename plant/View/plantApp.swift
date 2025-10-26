import SwiftUI

@main
struct plantApp: App {
    @StateObject private var plantStore = PlantStore()

    var body: some Scene {
        WindowGroup {
            MainPage()
                .environmentObject(plantStore) 
        }
    }
}
