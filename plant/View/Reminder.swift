import SwiftUI

struct reminder: View {
    @EnvironmentObject var plantStore: PlantStore
    @Environment(\.dismiss) var dismiss
    
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedWatering: String = "Everyday"
    @State private var selectedWater: String = "20-50ml"
    @State private var lightingType: String = "Full sun"
    
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let wateringDays = ["Everyday", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20-50ml", "50-100ml", "100-200ml", "200-300ml"]
    let lighting = ["Full sun", "Partial sun", "Low light"]
    
    var body: some View {
        Color.black.ignoresSafeArea()
            .overlay(
                VStack {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .padding()
                                .background(Color.black.opacity(0.9))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text("Reminders")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: addPlant) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(red: 71/255, green: 223/255, blue: 177/255))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    
                    Form {
                        Section(header: Text("Plant name").foregroundColor(.white)) {
                            TextField("Pothos", text: $plantName)
                                .foregroundColor(.white)
                        }
                        
                        Section(header: Text("Room").foregroundColor(.white)) {
                            Picker("Room", selection: $selectedRoom) {
                                ForEach(rooms, id: \.self) { Text($0) }
                            }.pickerStyle(.menu)
                        }
                        
                        Section(header: Text("Light").foregroundColor(.white)) {
                            Picker("Lighting", selection: $lightingType) {
                                ForEach(lighting, id: \.self) { Text($0) }
                            }.pickerStyle(.menu)
                        }
                        
                        Section(header: Text("Watering").foregroundColor(.white)) {
                            Picker("Watering days", selection: $selectedWatering) {
                                ForEach(wateringDays, id: \.self) { Text($0) }
                            }.pickerStyle(.menu)
                            
                            Picker("Water amount", selection: $selectedWater) {
                                ForEach(waterAmounts, id: \.self) { Text($0) }
                            }.pickerStyle(.menu)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.black)
                    .foregroundColor(.white)
                }
            )
    }
    
    func addPlant() {
        let newPlant = Plant(name: plantName.isEmpty ? "Pothos" : plantName,
                             location: selectedRoom,
                             sunRequirement: lightingType,
                             waterAmount: selectedWater)
        plantStore.addPlant(newPlant)
        dismiss()
    }
}
