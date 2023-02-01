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
    
    
    var body: some View {
        
        // MARK: NAVIGATION VIEW DECLARATION
        NavigationView {
            
            VStack {
                VStack(alignment: .leading){
                    Text("\(todayCal()) Kcal (Today)")
                        .foregroundColor(.gray)
                        .frame(width: 330, height: 40)
                        .padding(.horizontal)
                    
                    
                    
                    // list to display the information
                    // MARK: LIST DECLARATION
                    List{
                        Section {
                            ForEach(food) { food in
                                NavigationLink(destination: EditFoodView( food: food)){
                                    
                                    HStack{
                                        
                                        // MARK: LIST CONTENT
                                        VStack(alignment : .leading, spacing: 6){
                                            Text(food.name!)
                                                .bold()
                                            
                                            Text("\(Int(food.calories)) ")
                                                .foregroundColor(.red)
                                            +
                                            Text("calories")
                                                .foregroundColor(.red)
                                        }
                                        
                                        Spacer()
                                        
                                        Text("\(calTimeSince(date: food.date!))")
                                            .foregroundColor(.gray)
                                            .italic()
                                    }
                                }
                                
                            }
                            .onDelete(perform: deleteFood)
                            //                        .frame(width: 321, height: 50)
                            
                        } header: {
                            Text("Recent Calories Gained")
                        }
                    }
                    .listStyle(.plain)
                    
                    // background section clear
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                }
                
                // MARK: NAVIGATION BAR SETTINGS
                .navigationTitle("iCalories")
                .padding(.top,45)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarTrailing ){
                        Button {
                            print("Add button pressed")
                            showingAddView.toggle()
                        } label: {
                            Label("Add Food", systemImage: "plus.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                }
                
                // MARK: Popup Sheet
                .sheet(isPresented: $showingAddView){
                    AddFoodView()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .padding()
    }
    
    // MARK: DELETE FOOD
    private func deleteFood(offsets: IndexSet){
        withAnimation{
            offsets.map { food[$0]}.forEach(manageObjContext.delete)
            DataController().save(context: manageObjContext)
            print("data deleted")
        }
    }
    
    // MARK: COUNT CALORIES
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
