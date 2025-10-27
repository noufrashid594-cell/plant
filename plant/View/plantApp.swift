import SwiftUI

@main
struct plantApp: App {
    @StateObject private var plantViewModel = PlantViewModel()
    
    init() {
        // Request notification permission on app launch
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            MainPage()
                .environmentObject(plantViewModel)
                .onAppear {
                    // Reset badge count when app opens
                    NotificationManager.shared.resetBadgeCount()
                }
        }
    }
}
