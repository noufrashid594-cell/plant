//
//  AllRemindersClosed.swift
//  plant
//
//  Created by nouf on 02/05/1447 AH.
//

import SwiftUI

// MARK: - Reusable Components

/**
 A custom primary button style used for the floating action button.
 */
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
    // Placeholder function for the button action
    func addPlant() {
        print("Add Plant button tapped!")
        // In a real app, this would navigate to an 'Add Plant' screen
    }

    var body: some View {
        // Use a ZStack to place the content and the floating button
        ZStack(alignment: .bottomTrailing) {
            Color.black
                .ignoresSafeArea()

            // 1. Main content (dark background, centered text/image)
            VStack {
                // Header (Navigation-like Title)
                HStack {
                    Text("My Plants")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                   
                    Text("🌱")
                        .font(.largeTitle)
                    Spacer()
                }
                .foregroundColor(.white) // Ensure header text is white
                .padding(.horizontal)
                .padding(.top, 10)

                Spacer() // Pushes the content to the center

                // Center Content: Plant Image and Text
                VStack(spacing: 15) {
                    // Plant Image with circular frame
                    Image("plant2") // Using your specified image asset name
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4)) // Black stroke
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

                Spacer() // Pushes the content from the bottom
            }

            // 2. Floating Action Button (FAB)
            Button(action: addPlant) {
                Image(systemName: "plus")
            }
            .buttonStyle(FloatingButtonStyle())
            .padding(.trailing, 25)
            .padding(.bottom, 50)
            //.glassEffect()
        }
        
        .preferredColorScheme(.dark)
        
        
        
        // Force dark mode as shown in the screenshot
        // Removed .navigationTitle and .navigationBarTitleDisplayMode from here
        // as they are typically applied to the NavigationView that contains this view,
        // not the view itself when it's the root of the screen.
    }
}

// MARK: - Preview

struct AllRemindersClosed_Previews: PreviewProvider {
    static var previews: some View {
        AllRemindersClosed()
    }
}

