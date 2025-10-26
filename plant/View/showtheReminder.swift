import SwiftUI

struct ContentView3: View {
    var reminders: [PlantReminder] = [
        // Sample data used only when this view is constructed without injected reminders.
        // In normal navigation, AddReminder passes in the real reminders array.
        PlantReminder(plantName: "Monstera", room: "Kitchen", wateringFrequency: "Every 3 days", waterAmount: "20–50 ml", lighting: "Full sun"),
        PlantReminder(plantName: "Pothos", room: "Bedroom", wateringFrequency: "Once a week", waterAmount: "20–50 ml", lighting: "Full sun"),
        PlantReminder(plantName: "Orchid", room: "Living Room", wateringFrequency: "Every 10 days", waterAmount: "20–50 ml", lighting: "Full sun"),
        PlantReminder(plantName: "Spider", room: "Kitchen", wateringFrequency: "Every 2 weeks", waterAmount: "20–50 ml", lighting: "Full sun")
    ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 12) {
                    // Header
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Divider().background(Color.gray)
                    
                    // Subtitle + progress bar
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your plants are waiting for a sip 💦")
                            .foregroundColor(.white)
                            .font(.body)
                        
                        ProgressView(value: 0.0)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color.gray))
                            .frame(height: 6)
                    }
                    .padding(.bottom, 10)
                    
                    // Plant list
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(reminders) { reminder in
                                PlantCard(reminder: reminder)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Floating add button
                Button(action: {
                    print("Add plant tapped")
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct PlantCard: View {
    var reminder: PlantReminder
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "paperplane")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("in \(reminder.room)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            HStack(alignment: .center) {
                Text(reminder.plantName)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            HStack(spacing: 12) {
                Label(reminder.lighting, systemImage: "sun.max.fill")
                    .font(.caption)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.yellow)
                    .clipShape(Capsule())
                
                Label(reminder.waterAmount, systemImage: "drop.fill")
                    .font(.caption)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.blue)
                    .clipShape(Capsule())
                
                // Optional: show watering frequency
                Label(reminder.wateringFrequency, systemImage: "calendar")
                    .font(.caption)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.green)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground).opacity(0.15))
        .cornerRadius(12)
    }
}

#Preview {
    // Preview with sample data
    ContentView3()
}
