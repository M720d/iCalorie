//
//  TotalCaloriesToday.swift
//  CalorieApp SwiftUI
//
//  Created by Dev Salvi on 29/01/23.
//

import Foundation
import SwiftUI

struct TotalCaloriesToday {
    @Environment(\.managedObjectContext) var manageObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order : .reverse)]) var food : FetchedResults<Food>
    

}
