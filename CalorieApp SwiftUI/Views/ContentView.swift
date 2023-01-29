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
    
    //    var totalCaloriesToday = TotalCaloriesToday()
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading){
                Text("\(todayCal()) Kcal (Today)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                // list to display the information
                List{
                    ForEach(food) { food in
                        NavigationLink(destination: Text("\(food.calories)")){
                            HStack{
                                VStack(alignment : .leading, spacing: 6){
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text("\(Int(food.calories)) ") + Text("calories")
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Text("\(calTimeSince(date: food.date!))")
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                        
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
                
            }
            .navigationTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing ){
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView){
                AddFoodView()
            }
        }
        .padding()
    }
    
    private func deleteFood(offsets: IndexSet){
        withAnimation{
            offsets.map { food[$0]}.forEach(manageObjContext.delete)
            DataController().save(context: manageObjContext)
            print("data deleted")
        }
    }
    
    func todayCal( ) -> Int {
        var cal : Double = 0
        
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                cal += item.calories
            }
        }
        
        return Int(cal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
