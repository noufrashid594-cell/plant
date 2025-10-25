import Foundation

struct Plant: Identifiable {
    let id = UUID()
    var name: String
    var location: String
    var sunRequirement: String
    var waterAmount: String
    var isWatered: Bool = false
}
