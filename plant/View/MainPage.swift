//
//  MainPage.swift
//  plant
//
//  Created by nouf on 04/05/1447 AH.
//

import SwiftUI

struct MainPage: View {
    @EnvironmentObject var plantViewModel: PlantViewModel
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if plantViewModel.hasPlants {
                    ContentView3()
                } else {
                    emptyStateView
                }
            }
            .navigationTitle("My Plants 🌱")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .preferredColorScheme(.dark)
    }
    
    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Divider()
                .frame(height: 1)
                .overlay(Color.white.opacity(0.15))
                .padding(.horizontal)
                .padding(.bottom, 5)
            
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
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 71/255, green: 223/255, blue: 177/255))
            .padding(.top, 40)
            .sheet(isPresented: $isShowingSheet) {
                AddReminder()
            }
        }
        .padding(.bottom, 80)
    }
}

#Preview {
    MainPage()
        .environmentObject(PlantViewModel())
}
