//
//  SetReminderView.swift
//  plant
//
//  Created by nouf on 29/04/1447 AH.
//


import SwiftUI

struct SetReminderView: View {
    @State private var plantName: String = "Pothos"
    @State private var room: String = "Bedroom"
    @State private var light: String = "Full sun"
    @State private var wateringDays: String = "Every day"
    @State private var waterAmount: String = "20-50 ml"

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Top bar
                HStack {
                    Button(action: {
                        // Dismiss action
                    }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("Set Reminder")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        // Save action
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 71/255, green: 223/255, blue: 177/255)) // #47DFB1
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)

                // Input field
                RoundedTextField(
                    title: "Plant Name",
                    text: $plantName
                )
                .padding(.horizontal)
                
                // First section (Room & Light)
                VStack(spacing: 1) {
                    DropdownRow(icon: "paperplane", title: "Room", value: room)
                    Divider().background(Color.gray)
                    DropdownRow(icon: "sun.max", title: "Light", value: light)
                }
                .background(Color(.darkGray))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                
                // Second section (Watering Days & Water)
                VStack(spacing: 1) {
                    DropdownRow(icon: "drop", title: "Watering Days", value: wateringDays)
                    Divider().background(Color.gray)
                    DropdownRow(icon: "drop", title: "Water", value: waterAmount)
                }
                .background(Color(.darkGray))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 50)
        }
    }
}

struct RoundedTextField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Divider()
                .frame(height: 20)
                .background(Color(red: 71/255, green: 223/255, blue: 177/255)) // turquoise bar
            TextField("", text: $text)
                .foregroundColor(.gray)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
        .padding()
        .background(Color(.darkGray))
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

struct DropdownRow: View {
    var icon: String
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
            Image(systemName: "chevron.down")
                .foregroundColor(.gray)
        }
        .padding()
    }
}
