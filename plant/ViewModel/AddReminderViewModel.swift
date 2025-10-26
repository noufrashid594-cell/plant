//
//  AddReminderViewModel.swift
//  plant
//
//  Created by nouf on 04/05/1447 AH.
//

import SwiftUI
import Combine
class AddReminderViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var plantName: String = ""
    @Published var selectedRoom: String = "Bedroom"
    @Published var selectedWatering: String = "Everyday"
    @Published var selectedWater: String = "20-50ml"
    @Published var lightingType: String = "Full sun"
    @Published var showDeleteConfirmation: Bool = false
    
    // MARK: - Constants
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let wateringDays = ["Everyday", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20-50ml", "50-100ml", "100-200ml", "200-300ml"]
    let lighting = ["Full sun", "Partial sun", "Low light"]
    
    // MARK: - Validation
    var isValidInput: Bool {
        !plantName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    // MARK: - Methods
    func resetForm() {
        plantName = ""
        selectedRoom = "Bedroom"
        selectedWatering = "Everyday"
        selectedWater = "20-50ml"
        lightingType = "Full sun"
    }
    
    func showDeleteAlert() {
        showDeleteConfirmation = true
    }
}
