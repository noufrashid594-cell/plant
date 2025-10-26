//import SwiftUI
//
//struct ContentView2: View {
//    @EnvironmentObject var plantStore: PlantStore
//    
//    @State private var samplePlant = Plant(
//        name: "Snake Plant",
//        location: "Living Room",
//        sunRequirement: "Low Light",
//        waterAmount: "100ml"
//    )
//    @State private var samplePlant1 = Plant(
//        name: "Snake 777676",
//        location: "Living Room",
//        sunRequirement: "Low Light",
//        waterAmount: "100ml"
//    )
//    var body: some View {
//        
//        NavigationStack{
//            VStack{
//                VStack(alignment: .leading) {
//                    Text("Your plants are waiting for a sip 💦")
//                        .foregroundColor(.gray)
//                    
//                    PlantRowView(plant: $samplePlant)
//                    PlantRowView(plant: $samplePlant1)
//                    
//                    
//                }.padding(.top, -290)
//                
//                Button(action: {}) {
//                    Image(systemName: "plus")
//                        .font(.title)
//                        .foregroundColor(.black)
//                        .frame(width: 50, height: 70)
//                        .background(Circle().fill(Color(red: 71/255, green: 223/255, blue: 177/255)))
//                        .shadow(radius: 5)
//                }
//            }
//            .navigationTitle(Text("My Plants🌱"))
//        }
//    }
//}
//struct PlantRowView: View {
//    @Binding var plant: Plant
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack(spacing: 15) {
//                Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
//                    .resizable()
//                    .frame(width: 20, height: 20)
//                    .foregroundColor(plant.isWatered ? .green : .gray)
//                    .onTapGesture { plant.isWatered.toggle() }
//                
//                VStack(alignment: .leading, spacing: 4) {
//                    HStack(spacing: 4) {
//                        Image(systemName: "paperplane.fill").font(.caption2)
//                        Text(plant.location).font(.subheadline)
//                    }.foregroundColor(.gray)
//                    
//                    Text(plant.name)
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                    
//                    HStack(spacing: 8) {
//                        CareTagView(icon: "☀️", text: plant.sunRequirement)
//                        CareTagView(icon: "💧", text: plant.waterAmount)
//                    }
//                }
//                
//                Spacer()
//            }
//            .padding(.vertical, 12)
//            
//            Rectangle()
//                .frame(height: 1)
//                .foregroundColor(Color.white.opacity(0.15))
//        }
//        .contentShape(Rectangle())
//    }
//}
//
//struct CareTagView: View {
//    let icon: String
//    let text: String
//    
//    var body: some View {
//        HStack(spacing: 4) {
//            Text(icon).font(.caption2)
//            Text(text).font(.caption)
//        }
//        .padding(.horizontal, 8)
//        .padding(.vertical, 4)
//        .background(Color.white.opacity(0.1))
//        .cornerRadius(8)
//    }
//}
//#Preview {
//    ContentView2()
//}
