//
//  DataController.swift
//  CalorieApp SwiftUI
//
//  Created by Dev Salvi on 28/01/23.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    
    init(){
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load the data\(error.localizedDescription)")
            }
        }
    }
    
    // saving the local database
    func save(context : NSManagedObjectContext) {
        do {
            try
            context.save()
            print("Data Saved")
        }catch {
                print("Data not saved...")
            }
        
    }
    
    // adding the food data
    func addFood(name : String, calories : Double, context : NSManagedObjectContext){
        let food = Food(context: context)
        food.id = UUID()
        food.name = name
        food.calories = calories
        food.date = Date()
        
        save(context: context)
        
    }
    
    // editing the food data
    func editFood(food : Food , name : String, calories : Double ,context : NSManagedObjectContext){
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
}
