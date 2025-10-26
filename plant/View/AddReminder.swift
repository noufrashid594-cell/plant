//
//  AddReminder.swift
//  plant
//
//  Created by nouf on 04/05/1447 AH.
//

import SwiftUI

struct PlantReminder: Identifiable, Codable {
    let id = UUID()
    var plantName: String
    var room: String
    var wateringFrequency: String
    var waterAmount: String
    var lighting: String
}

struct AddReminder: View {
    @State private var isActive = false
    @State private var MainPageSwitcher = false
    
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedWatering: String = "Everyday"
    @State private var selectedWater: String = "20-50ml"
    @State private var lightingType: String = "Full sun"
    
    // 👇 Shared array to store reminders
    @State private var reminders: [PlantReminder] = []
    
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let wateringDays = ["Everyday", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20-50ml", "50-100ml", "100-200ml", "200-300ml"]
    let lighting = ["Full sun", "Partial sun", "Low light"]
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        MainPageSwitcher = true
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        // ✅ Create a new reminder and add to array
                        let newReminder = PlantReminder(
                            plantName: plantName,
                            room: selectedRoom,
                            wateringFrequency: selectedWatering,
                            waterAmount: selectedWater,
                            lighting: lightingType
                        )
                        
                        reminders.append(newReminder)
                        isActive = true
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(.green).opacity(0.65))
                }
            }
            
            // ✅ Pass the array to ContentView2
            .navigationDestination(isPresented: $isActive) {
                ContentView3(reminders: reminders)
            }
        }
    }
}
#Preview {
    AddReminder()
}
