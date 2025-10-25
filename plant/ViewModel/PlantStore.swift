import SwiftUI
import Combine

class PlantStore: ObservableObject {
    @Published var plants: [Plant] = []

    func addPlant(_ plant: Plant) {
        plants.append(plant)
    }
}
