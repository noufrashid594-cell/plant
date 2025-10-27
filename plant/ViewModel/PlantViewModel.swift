import SwiftUI
import Combine

class PlantViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var plants: [Plant] = []
    
    private let notificationManager = NotificationManager.shared
    
    // MARK: - Computed Properties
    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }
    
    var totalCount: Int {
        plants.count
    }
    
    var progress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(wateredCount) / Double(totalCount)
    }
    
    var hasPlants: Bool {
        !plants.isEmpty
    }
    
    var allPlantsWatered: Bool {
        wateredCount == totalCount && totalCount > 0
    }
    
    var progressMessage: String {
        allPlantsWatered ? "All plants watered! 🎉" : "Your plants are waiting for a sip 💦"
    }
    
    // MARK: - Business Logic Methods
    
    /// Add a new plant to the collection
    func addPlant(_ plant: Plant) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            plants.append(plant)
        }
        
        // Schedule notification for the new plant
        scheduleNotificationIfAuthorized(for: plant)
    }
    
    /// Toggle the watered status of a specific plant
    func toggleWatered(for plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                plants[index].isWatered.toggle()
                
                // If plant is watered, reschedule notification
                if plants[index].isWatered {
                    rescheduleNotification(for: plants[index])
                }
            }
        }
    }
    
    /// Delete a specific plant
    func deletePlant(_ plant: Plant) {
        // Cancel notification before deleting
        notificationManager.cancelNotification(for: plant)
        
        withAnimation(.easeOut(duration: 0.3)) {
            plants.removeAll { $0.id == plant.id }
        }
    }
    
    /// Delete plants at specific indices
    func deletePlants(at offsets: IndexSet) {
        // Cancel notifications for plants being deleted
        offsets.forEach { index in
            notificationManager.cancelNotification(for: plants[index])
        }
        
        withAnimation(.easeOut(duration: 0.3)) {
            plants.remove(atOffsets: offsets)
        }
    }
    
    /// Create a plant from form data
    func createPlant(
        name: String,
        location: String,
        sunRequirement: String,
        waterAmount: String,
        wateringFrequency: String
    ) -> Plant {
        Plant(
            name: name.isEmpty ? "Unnamed Plant" : name,
            location: location,
            sunRequirement: sunRequirement,
            waterAmount: waterAmount,
            wateringFrequency: wateringFrequency
        )
    }
    
    /// Reset all plants watering status
    func resetAllWateringStatus() {
        withAnimation {
            for index in plants.indices {
                plants[index].isWatered = false
            }
        }
        
        // Reschedule all notifications
        rescheduleAllNotifications()
    }
    
    /// Mark all plants as watered
    func waterAllPlants() {
        withAnimation {
            for index in plants.indices {
                plants[index].isWatered = true
            }
        }
    }
    
    // MARK: - Notification Methods
    
    /// Request notification permission
    func requestNotificationPermission() async {
        _ = await notificationManager.requestAuthorization()
    }
    
    /// Schedule notification if authorized
    private func scheduleNotificationIfAuthorized(for plant: Plant) {
        if notificationManager.isAuthorized {
            notificationManager.scheduleNotification(for: plant)
        }
    }
    
    /// Reschedule notification for a plant
    private func rescheduleNotification(for plant: Plant) {
        notificationManager.scheduleNotification(for: plant)
    }
    
    /// Reschedule all notifications
    func rescheduleAllNotifications() {
        plants.forEach { plant in
            notificationManager.scheduleNotification(for: plant)
        }
    }
    
    /// Cancel all notifications
    func cancelAllNotifications() {
        notificationManager.cancelAllNotifications()
    }
}
