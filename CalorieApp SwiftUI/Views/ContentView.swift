//
//  ContentView.swift
//  CalorieApp SwiftUI
//
//  Created by Dev Salvi on 28/01/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var manageObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order : .reverse)]) var food : FetchedResults<Food>
    // fetching the data from the storage, sorting and reverse data
    
    @State private var showingAddView = false // our new pop up page for adding the food
    
    var totalCaloriesToday = TotalCaloriesToday()
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading){
                Text("\(totalCaloriesToday.todayCal()) Kcal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                

            }
            .navigationTitle("iCalories")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
