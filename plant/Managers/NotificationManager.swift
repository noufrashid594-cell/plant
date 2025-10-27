
//
//  NotificationManager.swift
//  plant
//
//  Created by nouf on 04/05/1447 AH.
//

import Foundation
import UserNotifications
import Combine
class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    @Published var isAuthorized = false
    
    private init() {
        checkAuthorizationStatus()
    }
    
    // MARK: - Request Permission
    func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
            
            await MainActor.run {
                self.isAuthorized = granted
            }
            
            return granted
        } catch {
            print("Error requesting notification permission: \(error)")
            return false
        }
    }
    
    // MARK: - Check Authorization Status
    func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }
    
    // MARK: - Schedule Notification for Plant
    func scheduleNotification(for plant: Plant) {
        // Remove existing notification for this plant
        cancelNotification(for: plant)
        
        let content = UNMutableNotificationContent()
        content.title = "Time to water your plant! 💧"
        content.body = "\(plant.name) in \(plant.location) needs watering"
        content.sound = .default
        content.badge = 1
        
        // Convert watering frequency to time interval
        let interval = getTimeInterval(from: plant.wateringFrequency)
        
        // Create trigger (for testing, use 10 seconds; for production, use the interval)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)

        
        // Create request
        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        // Schedule notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled for \(plant.name)")
            }
        }
    }
    
    // MARK: - Cancel Notification
    func cancelNotification(for plant: Plant) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }
    
    // MARK: - Cancel All Notifications
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    // MARK: - Get Scheduled Notifications
    func getScheduledNotifications() async -> [UNNotificationRequest] {
        return await UNUserNotificationCenter.current().pendingNotificationRequests()
    }
    
    // MARK: - Convert Watering Frequency to Time Interval
    private func getTimeInterval(from frequency: String) -> TimeInterval {
        // ⚠️ TESTING MODE - SHORT INTERVALS ⚠️
        // Remove this and restore original after testing!
        
        switch frequency {
        case "Everyday":
            return 10 // 10 seconds (was 86400)
        case "Every 2 days":
            return 20 // 20 seconds (was 172800)
        case "Every 3 days":
            return 30 // 30 seconds (was 259200)
        case "Once a week":
            return 60 // 1 minute (was 604800)
        case "Every 10 days":
            return 120 // 2 minutes (was 864000)
        case "Every 2 weeks":
            return 180 // 3 minutes (was 1209600)
        default:
            return 10 // Default to 10 seconds
        }
    }
    
    // MARK: - Reset Badge Count
    func resetBadgeCount() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
}
