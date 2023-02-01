//
//  EditFoodView.swift
//  CalorieApp SwiftUI
//
//  Created by Dev Salvi on 01/02/23.
//

import SwiftUI

struct EditFoodView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext // represents the whole data in the database
    
    @Environment(\.dismiss) var dismiss // takes us back to main navigation view
    
    var food : FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories : Double = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment : .leading) {
                Form{
                    Section{
                        TextField("\(food.name!)", text: $name)
                            .onAppear(){
                                name = food.name!
                                calories = food.calories
                            }
                        
                        VStack{
                            Text("Calories : \(Int(calories))")
                            Slider(value: $calories , in : 0...1000, step: 1)
                            
                        }
                        .padding()
                        
                        Spacer()
                        
                        // MARK: SUBMIT BUTTON
                        HStack{
                            Spacer()
                            Button("Submit"){
                                
                                DataController().editFood(food: food, name: name, calories: calories, context: managedObjContext)
                                
                                dismiss() // dismissing the current view
                                
                            }
                            Spacer()
                        }
                        
                    } header : {
                    Text("Enter food details")
                }
            }
            .scrollContentBackground(.hidden)  // section bg clear
            .navigationTitle("Edit food details")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}
}
//
//struct EditFoodView_Previews: PreviewProvider {
//    typealias Previews = <#type#>
//
//    var food1 : [FetchedResults<Food>.Element]
//     var previews: some View {
//        EditFoodView( food : food1)
//    }
//}
