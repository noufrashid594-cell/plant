import SwiftUI

// MARK: - 1. Data Model

// Represents a single plant in the list.
struct Plant: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let sunRequirement: String
    let waterAmount: String
    // Changed to 'var' so we can toggle the state.
    var isWatered: Bool = false
}

// Sample data to populate the list.
let samplePlants = [
    Plant(name: "Monstera", location: "in Kitchen", sunRequirement: "Full sun", waterAmount: "20-50 ml"),
    Plant(name: "Pothos", location: "in Bedroom", sunRequirement: "Full sun", waterAmount: "20-50 ml"),
    Plant(name: "Orchid", location: "in Living Room", sunRequirement: "Full sun", waterAmount: "20-50 ml"),
    Plant(name: "Spider", location: "in Kitchen", sunRequirement: "Full sun", waterAmount: "20-50 ml")
]

// MARK: - 2. Reusable Component for Care Tags

// A small, rounded view for showing care details (Sun/Water)
struct CareTagView: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(icon)
                .font(.caption2)
            Text(text)
                .font(.caption)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.white.opacity(0.1))
        .cornerRadius(8)
    }
}

// MARK: - 3. Plant Row View

struct PlantRowView: View {
    // Use @Binding to correctly modify the plant's state in the parent list (ContentView).
    @Binding var plant: Plant
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 15) {
                // Checkbox / Radio Button
                Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    // The icon color is now dynamic based on the binding.
                    .foregroundColor(plant.isWatered ? .green : .gray)
                    .onTapGesture {
                        // Toggling the binding updates the source of truth in ContentView.
                        plant.isWatered.toggle()
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    // Location
                    HStack(spacing: 4) {
                        Image(systemName: "paperplane.fill")
                            .font(.caption2)
                        Text(plant.location)
                            .font(.subheadline)
                    }
                    .foregroundColor(.gray)
                    
                    // Plant Name
                    Text(plant.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    // Care Tags
                    HStack(spacing: 8) {
                        CareTagView(icon: "☀️", text: plant.sunRequirement)
                        CareTagView(icon: "💧", text: plant.waterAmount)
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 12)
            
            // Custom Divider line
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.white.opacity(0.15))
        }
        .contentShape(Rectangle())
    }
}

// MARK: - 4. Main Content View

struct ContentView2: View {
    // State to hold the list of plants, allowing for checkmark changes.
    @State private var plants: [Plant] = samplePlants
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Background and Main Content
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Your plants are waiting for a sip 💦")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    
                
                    
                    //progress bar
                    ProgressView(value: 0.3)
                        .progressViewStyle(LinearProgressViewStyle(tint:Color (red: 71/255, green: 223/255, blue: 177/255)))
                        .padding(.trailing, 20)
                    
   

                }
                .padding(.horizontal)
                .padding(.top, 50) // Padding from top edge

                // Plant List (Using ScrollView to replicate custom list style)
                ScrollView {
                    VStack(spacing: 0) {
                        // Crucial change: Using $plant to pass a binding to the row.
                        ForEach($plants) { $plant in
                            PlantRowView(plant: $plant)
                                .padding(.horizontal)
                        }
                    }
                }
                // Push content up, making space for the FAB
                Spacer()
            }
            
            // Floating Action Button (FAB)
            Button(action: {
                // Action to add a new plant
                print("Add new plant tapped")
            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width: 50, height: 70)
                    .background(
                        Circle()
                        
                            .fill(Color(red: 71/255, green: 223/255, blue: 177/255)) // Use a bright color for visibility
                        //المفروض قزاز الله المستعان
                            .buttonStyle(.glassProminent)
                            .shadow(radius: 5)
                    )
            }
            .padding(25) // Offset from the bottom trailing edge
        }
    }
}

// MARK: - Preview (Used by Xcode Canvas)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}


