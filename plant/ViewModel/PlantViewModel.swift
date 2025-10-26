//
//  PlantViewModel.swift
//  plant
//
//  Created by nouf on 04/05/1447 AH.
//

import SwiftUI
import Combine

class PlantViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var plants: [Plant] = []
    
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
    }
    
    /// Toggle the watered status of a specific plant
    func toggleWatered(for plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                plants[index].isWatered.toggle()
            }
        }
    }
    
    /// Delete a specific plant
    func deletePlant(_ plant: Plant) {
        withAnimation(.easeOut(duration: 0.3)) {
            plants.removeAll { $0.id == plant.id }
        }
    }
    
    /// Delete plants at specific indices
    func deletePlants(at offsets: IndexSet) {
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
    }
    
    /// Mark all plants as watered
    func waterAllPlants() {
        withAnimation {
            for index in plants.indices {
                plants[index].isWatered = true
            }
        }
    }
}
