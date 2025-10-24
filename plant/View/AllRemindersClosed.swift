//
//  AllRemindersClosed.swift
//  plant
//
//  Created by nouf on 02/05/1447 AH.
//

import SwiftUI
struct AllRemindersClosed: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                VStack(spacing: 8) {
                    Divider()
                        .background(Color.white.opacity(0.8))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                Spacer()
                
                
                Image("plant2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                
                
                VStack(spacing: 10) {
                    Text("Well Done!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                
                
                
                
                
            }
            
        }
        
        
        .navigationTitle("My Plants 🌱").navigationBarTitleDisplayMode(.automatic)
    }
}
#Preview {
   AllRemindersClosed()
}
