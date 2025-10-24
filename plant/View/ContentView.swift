//
//  ContentView.swift
//  plant
//
//  Created by nouf on 28/04/1447 AH.
//

import SwiftUI

struct ContentView: View {
    @State  var isShowingSheet = false

    var body: some View {

        NavigationStack {
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
                     
                    
                    
                    
                    Image("plant1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    // Spacer()
                    
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
                                          .frame(width: 280, height: 30) // <- size the label BEFORE the style

                                  }
                                  .buttonStyle(.glassProminent)
                                  .tint(Color(red: 71/255, green: 223/255, blue: 177/255))
                                  .padding(.top, 40)
                                  .sheet(isPresented: $isShowingSheet)
                                                     {
                                                         reminder()
                                                          }
                    
                    
                        .padding(.horizontal, 40)
                        .padding(.bottom, 80)
                }
                
            }.navigationTitle("My Plant 🌱")
.navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    ContentView() .preferredColorScheme(.dark)
}
