//
//  NotificationSettings.swift
//  plant
//
//  Created by nouf on 05/05/1447 AH.

import SwiftUI

struct NotificationSettingsView: View {
    @EnvironmentObject var plantViewModel: PlantViewModel
    @StateObject private var notificationManager = NotificationManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notification Status")) {
                    HStack {
                        Text("Notifications")
                        Spacer()
                        Text(notificationManager.isAuthorized ? "Enabled" : "Disabled")
                            .foregroundColor(notificationManager.isAuthorized ? .green : .red)
                    }
                }
                
                Section(header: Text("Actions")) {
                    if !notificationManager.isAuthorized {
                        Button("Enable Notifications") {
                            Task {
                                await plantViewModel.requestNotificationPermission()
                            }
                        }
                    }
                    
                    Button("Reschedule All Notifications") {
                        plantViewModel.rescheduleAllNotifications()
                    }
                    
                    Button("Cancel All Notifications", role: .destructive) {
                        plantViewModel.cancelAllNotifications()
                    }
                }
                
                Section(header: Text("Info")) {
                    Text("You will receive reminders based on each plant's watering schedule.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
