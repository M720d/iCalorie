//
//  AddFoodView.swift
//  CalorieApp SwiftUI
//
//  Created by Dev Salvi on 28/01/23.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext // represents the whole data in the database
    
    @Environment(\.dismiss) var dismiss // takes us back to main navigation view
    
    @State private var name = ""
    @State private var calories : Double = 0
    @State private var showingAlert = false
    
    var body: some View {
        Form{
            Section{
                TextField("Food Name", text: $name)// text bounding to name
                
                VStack{
                    Text("Calories : \(Int(calories))")
                    Slider(value: $calories , in : 0...1000, step: 1)
                    
                }
                .padding()
                
                Spacer()
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        
                        if name == "" || calories == 0 {
                            showingAlert = true
                        }
                        
                        else if name != "" && calories != 0 {
                            DataController().addFood(name: name, calories: calories, context: managedObjContext)
                            
                            dismiss() // dismissing the current view
                            
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Invalid Entry"), message: Text("Fill all the details"), dismissButton: .default(Text("Got it!")))
                            }

                    Spacer()
                }
            }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
