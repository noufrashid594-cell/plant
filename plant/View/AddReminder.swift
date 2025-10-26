//
//  AddReminder.swift
//  plant
//
//  Created by nouf on 04/05/1447 AH.
//

import SwiftUI

struct AddReminder: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var plantViewModel: PlantViewModel
    @StateObject private var viewModel = AddReminderViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Form {
                        Section(header: Text("Plant name").foregroundColor(.white)) {
                            TextField("Pothos", text: $viewModel.plantName)
                                .foregroundColor(.white)
                        }
                        
                        Section(header: Text("Room").foregroundColor(.white)) {
                            Picker("Room", selection: $viewModel.selectedRoom) {
                                ForEach(viewModel.rooms, id: \.self) { Text($0) }
                            }.pickerStyle(.menu)
                        }
                        
                        Section(header: Text("Light").foregroundColor(.white)) {
                            Picker("Lighting", selection: $viewModel.lightingType) {
                                ForEach(viewModel.lighting, id: \.self) { Text($0) }
                            }.pickerStyle(.menu)
                        }
                        
                        Section(header: Text("Watering").foregroundColor(.white)) {
                            Picker("Watering days", selection: $viewModel.selectedWatering) {
                                ForEach(viewModel.wateringDays, id: \.self) { Text($0) }
                            }.pickerStyle(.menu)
                            
                            Picker("Water amount", selection: $viewModel.selectedWater) {
                                ForEach(viewModel.waterAmounts, id: \.self) { Text($0) }
                            }.pickerStyle(.menu)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                    // Delete Reminder Button
                    Button(action: {
                        viewModel.showDeleteAlert()
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Reminder")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.red)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    .padding()
                    .alert("Delete Reminder", isPresented: $viewModel.showDeleteConfirmation) {
                        Button("Cancel", role: .cancel) { }
                        Button("Delete", role: .destructive) {
                            dismiss()
                        }
                    } message: {
                        Text("Are you sure you want to delete this reminder?")
                    }
                }
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        saveReminder()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(.green).opacity(0.65))
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    // MARK: - Private Methods
    private func saveReminder() {
        let newPlant = plantViewModel.createPlant(
            name: viewModel.plantName,
            location: viewModel.selectedRoom,
            sunRequirement: viewModel.lightingType,
            waterAmount: viewModel.selectedWater,
            wateringFrequency: viewModel.selectedWatering
        )
        plantViewModel.addPlant(newPlant)
        dismiss()
    }
}

#Preview {
    AddReminder()
        .environmentObject(PlantViewModel())
}
