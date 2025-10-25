import SwiftUI

struct Splash: View {
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    // The requested Divider
                        Divider()
                        .frame(height: 1) // Set a fixed height for consistency
                        .overlay(Color.white.opacity(0.15)) // Make it a subtle grey on black
                        .padding(.horizontal)
                        .padding(.bottom, 5) // Add slight space below the divider
                    Spacer()
                    Image("plant1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Spacer()
                    VStack(spacing: 10) {
                        Text("Start your plant journey!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 30)
                        
                    }
                    
                    Spacer()
                    
                    Button {
                        isShowingSheet.toggle()
                    } label: {
                        Text("Set Plant Reminder")
                            .font(.system(size: 17, weight: .regular))
                            .frame(width: 280, height: 30)
                    }
                    .buttonStyle(.glassProminent)
                    .tint(Color(red: 71/255, green: 223/255, blue: 177/255))
                    .padding(.top, 40)
                    .sheet(isPresented: $isShowingSheet) {
                        reminder()
                    }
                }
                .padding(.bottom, 80)
            }
            .navigationTitle("My Plant 🌱")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    Splash().preferredColorScheme(.dark)
}
