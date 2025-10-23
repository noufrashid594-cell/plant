//
//  reminder.swift
//  plant
//
//  Created by nouf on 29/04/1447 AH.
//

import SwiftUI

struct reminder: View {
    @Environment(\.presentationMode) var presentationMode
    enum roomType : String, CaseIterable, Identifiable {
           case bedroom = "Bedroom"
           case Living = "Living Room"
           case Kitchen = "Kitchen"
           case Balcony = "Balcony"
           case Bathroom = "Bathroom"
        var id: String { rawValue }

          }
    enum wateringDays: String, CaseIterable, Identifiable {
           case everyDay = "Everyday"
           case everyTwo = "Every 2 days"
           case everyThree = "Every 3 days"
           case oneWeek = "Once a week"
           case everyTen = "Every 10 days"
           case twoWeek = "Every 2 weeks"
           
           var id: String { rawValue}
       }
       
    enum waterAmount: String, CaseIterable, Identifiable {
          case oneMl = "20-50ml"
          case twoMl = "50-100ml"
          case threeMl = "100-200ml"
          case fourMl = "200-300ml"
          
          var id: String { rawValue}
      }
      
      enum lighting: String, CaseIterable, Identifiable {
          case full = "Full sun"
          case partial = "Partial sun"
          case lowLight = "Low light"
          
          var id: String{ rawValue }
      }
      
      @State var selectedRoom: roomType = .bedroom
      @State var selectedWatering: wateringDays = .everyDay
      @State var selectedWater: waterAmount = .oneMl
      @State var lightingType: lighting = .full
    
    var body: some View {
        
            Color.black.ignoresSafeArea()
     
       
              VStack{
                HStack() {
                 
                   Button(action:{
                       //قفل الشييت
                   }) {
                       Image(systemName: "xmark")
                           .font(.title2)
                           .padding()
                           .background(Color.black.opacity(0.9))
                           .clipShape(Circle())
                           .buttonStyle(.glass)
                           .tint(Color.white)
                       
                           
                   }
                   
                    Spacer()
                
                    Text("Reminders")
                        .foregroundColor(.white)
                        .font(.headline)
                   Spacer()
                          
                    Button(action: {
                                           // زر الصح
                                       }) {
                                           Image(systemName: "checkmark")
                                               .foregroundColor(.white)
                                               .padding()
                                               .background(Color(red: 71/255, green: 223/255, blue: 177/255)) // #47DFB1
                                               .clipShape(Circle())
                                       }
                                   }
                                   .padding(.horizontal)
                                
                  //GROUP OF FORM
                  VStack{
                      
                      //First form
                      HStack{
                          Spacer()
                          Text("Plant name")
                              .padding(2)
                              .font(Font.system(size: 18, weight: .regular))
                              .foregroundStyle(Color.white)
                          
                          TextField("Pothos", text: .constant(""))
                              .foregroundStyle(Color.white.opacity(0.8))
                              .tint(Color.green) // changes cursor (insertion point) color
                              .font(Font.system(size: 18, weight: .regular))
                          //    .padding(.trailing, 20)
                          
                          
                      }//end of first form
                      .frame(height: 60)
                      //.padding(18)hhkm
                      .background(Color("Formgroup"))
                      .cornerRadius(30)
                      //                    .padding(.trailing, 6)
                      //                    .padding(.leading, 6)
                      
                      
                      Spacer()
                      
                
                      
                      
                  }
                                
                   
                  
                  VStack{
                      HStack{
                          HStack{
                              
                              Image(systemName: "location")
                                  .foregroundStyle(.white)
                                  .font(Font.system(size: 18, weight: .regular))
                              
                              Text("Room")
                                  .font(Font.system(size: 18, weight: .regular))
                                  .foregroundStyle(Color.white)
                              
                          }
                          
                          Spacer()
                          // Right Picker (menu)
                          
                          Picker("selectedroom", selection: $selectedRoom){
                              
                              ForEach(roomType.allCases){ room in
                                  Text(room.rawValue).tag(room)}
                          }
                          .pickerStyle(.menu)
                          .tint(.gray) // color of the selected value and caret icon
                       
                      }
                      .padding(.trailing, 12)
                    .padding(.leading, 12)
                      .padding(6)
                      
                      Divider()
                      .frame(height: 0.5)               // thickness
                      .background(Color.gray.opacity(0.3))
                      HStack{
                          Image(systemName: "sun.max")
                              .foregroundStyle(.white)
                              .font(Font.system(size: 18, weight: .regular))
                          Text("Light")
                              .font(Font.system(size: 18, weight: .regular))
                              .foregroundStyle(Color.white)
                          Spacer()
                          // Right Picker (menu)
                          HStack{
                          Picker("selectedroom", selection: $lightingType){
                              ForEach(lighting.allCases){ light in
                                  Text(light.rawValue).tag(light)}
                          }
                      }
                          .pickerStyle(.menu)
                          .tint(.gray) // color of the selected value and caret icon
                          
                      }
                      .padding(.trailing, 12)
                    .padding(.leading, 12)
                    .padding(6)

                  }
                  
                  .background(Color("Formgroup"))
                  .cornerRadius(30)
                  .padding(.trailing, 6)
                  .padding(.leading, 6)
                  
                  
                  
                  //Third form
                  VStack{
                      //last commit here in the HSTACK
                      HStack{
                          HStack{
                              
                              Image(systemName: "drop")
                                  .foregroundStyle(.white)
                                  .font(Font.system(size: 18, weight: .regular))
                              Text("Watering days")
                                  .font(Font.system(size: 18, weight: .regular))
                                  .foregroundStyle(Color.white)
                              Spacer()
                          }
                          // Right Picker (menu)
                          
                          Picker("selectedroom", selection: $selectedWatering){
                              
                              ForEach(wateringDays.allCases){ days in
                                  Text(days.rawValue).tag(days)}
                          }
                          .pickerStyle(.menu)
                          .tint(.gray) // color of the selected value and caret icon
                      }
                      .padding(.trailing, 12)
                    .padding(.leading, 12)
                    .padding(6)

      
                      Divider()
                      .frame(height: 0.5)               // thickness
                      .background(Color.gray.opacity(0.3))
                      HStack{
                          Image(systemName: "drop")
                              .foregroundStyle(.white)
                              .font(Font.system(size: 18, weight: .regular))
                          Text("Water")
                              .font(Font.system(size: 18, weight: .regular))
                              .foregroundStyle(Color.white)
                          Spacer()
                          
                      
                          // Right Picker (menu)
                          HStack{
                          Picker("selectedroom", selection: $selectedWater){
                              ForEach(waterAmount.allCases){ amount in
                                  Text(amount.rawValue).tag(amount)}
                          }
                      }
                          
                          .pickerStyle(.menu)
                          .tint(.gray) // color of the selected value and caret icon
                        
                          
                      }
                      .padding(.trailing, 12)
                    .padding(.leading, 12)
                    .padding(6)

               
                  }
                  .frame(width: .infinity)
                  .background(Color("Formgroup"))
                  .cornerRadius(30)
                  .padding(.trailing, 3)
                .padding(.leading, 3)
                .padding(.top, 25)
                  Spacer().frame(height: 320)

                 

                 
                  .padding(15)
                  //end of second form

                  
                  
                    }
             
              
                            
                   
                      }
                
                
               
               
          
            

            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    




    

    

