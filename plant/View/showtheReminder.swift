import SwiftUI

struct ContentView3: View {
    @EnvironmentObject var plantViewModel: PlantViewModel
    @State private var isShowingAddPlant = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color.black.ignoresSafeArea()
                
                if plantViewModel.hasPlants {
                    if plantViewModel.allPlantsWatered {
                        // Show completion screen when all plants are watered
                        AllRemindersClosed(isShowingAddPlant: $isShowingAddPlant)
                    } else {
                        // Show plant list
                        plantListView
                    }
                } else {
                    // Show empty state
                    emptyStateView
                }
                
                // Only show floating button if not all plants are watered
                if !plantViewModel.allPlantsWatered {
                    floatingAddButton
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Subviews
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 80))
                .foregroundColor(.green.opacity(0.5))
            
            Text("No plants yet")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("Add your first plant to get started")
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Center the content
    }
    
    private var plantListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            Divider().background(Color.gray)
            progressBarView
            plantScrollView
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var headerView: some View {
        Text("")
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(.white)
            .padding(.top, 10)
    }
    
    private var progressBarView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(plantViewModel.progressMessage)
                    .foregroundColor(.white)
                    .font(.body)
                
                Spacer()
                
                Text("\(plantViewModel.wateredCount)/\(plantViewModel.totalCount)")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            AnimatedProgressBar(progress: plantViewModel.progress)
        }
        .padding(.bottom, 10)
    }
    
    private var plantScrollView: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(plantViewModel.plants) { plant in
                    PlantCard(plant: plant)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .scale.combined(with: .opacity)
                        ))
                }
            }
        }
    }
    
    private var floatingAddButton: some View {
        Button(action: {
            isShowingAddPlant = true
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
        .sheet(isPresented: $isShowingAddPlant) {
            AddReminder()
        }
    }
}

// MARK: - Animated Progress Bar Component
struct AnimatedProgressBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 8)
                    .cornerRadius(4)
                
                // Progress fill with animation
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green, Color.green.opacity(0.7)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geometry.size.width * progress, height: 8)
                    .cornerRadius(4)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: progress)
            }
        }
        .frame(height: 8)
    }
}

// MARK: - Plant Card Component
struct PlantCard: View {
    @EnvironmentObject var plantViewModel: PlantViewModel
    let plant: Plant
    
    var body: some View {
        HStack {
            checkboxButton
            plantInfoView
            Spacer()
        }
        .padding()
        .background(cardBackground)
        .overlay(cardBorder)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            deleteButton
        }
    }
    
    // MARK: - Subviews
    
    private var checkboxButton: some View {
        Button(action: {
            plantViewModel.toggleWatered(for: plant)
        }) {
            Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 24))
                .foregroundColor(plant.isWatered ? .green : .gray)
        }
        .padding(.trailing, 8)
    }
    
    private var plantInfoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            locationLabel
            plantNameText
            infoTags
        }
    }
    
    private var locationLabel: some View {
        HStack(spacing: 6) {
            Image(systemName: "paperplane")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            Text("in \(plant.location)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    private var plantNameText: some View {
        Text(plant.name)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(plant.isWatered ? .gray : .white)
            .strikethrough(plant.isWatered, color: .gray)
    }
    
    private var infoTags: some View {
        HStack(spacing: 12) {
            InfoTag(icon: "sun.max.fill", text: plant.sunRequirement, color: .yellow)
            InfoTag(icon: "drop.fill", text: plant.waterAmount, color: .blue)
            InfoTag(icon: "calendar", text: plant.wateringFrequency, color: .green)
        }
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(.secondarySystemBackground).opacity(plant.isWatered ? 0.08 : 0.15))
    }
    
    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(plant.isWatered ? Color.green.opacity(0.3) : Color.clear, lineWidth: 1)
    }
    
    private var deleteButton: some View {
        Button(role: .destructive) {
            plantViewModel.deletePlant(plant)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

// MARK: - Info Tag Component
struct InfoTag: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        Label(text, systemImage: icon)
            .font(.caption)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.gray.opacity(0.2))
            .foregroundColor(color)
            .clipShape(Capsule())
    }
}

#Preview {
    ContentView3()
        .environmentObject(PlantViewModel())
}
