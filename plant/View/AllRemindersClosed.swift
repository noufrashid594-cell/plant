//
//  AllRemindersClosed.swift
//  plant
//
//  Created by nouf on 02/05/1447 AH.
//

import SwiftUI

// MARK: - Reusable Components

struct FloatingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.white)
            .padding(16)
            .background(
                Circle()
                    .fill(Color(red: 0.17, green: 0.70, blue: 0.40))
                    .shadow(radius: 10)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Main View

struct AllRemindersClosed: View {
    @Binding var isShowingAddPlant: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black
                .ignoresSafeArea()

            // Main content (dark background, centered text/image)
            VStack {
                // Header (Navigation-like Title)
                HStack {
                    Text("")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                   
                    Text("")
                        .font(.largeTitle)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, 10)

                Spacer()

                // Center Content: Plant Image and Text
                VStack(spacing: 15) {
                    // Plant Image with circular frame
                    Image("plant2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4))
                        .shadow(radius: 10)
                    
                    // The "All Done!" text
                    Text("All Done! 🎉")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    // The subtitle
                    Text("All Reminders Completed")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            // Floating Action Button (FAB)
            Button(action: {
                isShowingAddPlant = true
            }) {
                Image(systemName: "plus")
            }
            .buttonStyle(FloatingButtonStyle())
            .padding(.trailing, 25)
            .padding(.bottom, 50)
            .sheet(isPresented: $isShowingAddPlant) {
                AddReminder()
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Preview

struct AllRemindersClosed_Previews: PreviewProvider {
    static var previews: some View {
        AllRemindersClosed(isShowingAddPlant: .constant(false))
            .environmentObject(PlantViewModel())
    }
}
