import Foundation

struct Plant: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var location: String
    var sunRequirement: String
    var waterAmount: String
    var wateringFrequency: String
    var isWatered: Bool
    
    init(id: UUID = UUID(),
         name: String,
         location: String,
         sunRequirement: String,
         waterAmount: String,
         wateringFrequency: String,
         isWatered: Bool = false) {
        self.id = id
        self.name = name
        self.location = location
        self.sunRequirement = sunRequirement
        self.waterAmount = waterAmount
        self.wateringFrequency = wateringFrequency
        self.isWatered = isWatered
    }
}
