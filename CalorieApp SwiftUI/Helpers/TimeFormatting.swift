//
//  TimeFormatting.swift
//  CalorieApp SwiftUI
//
//  Created by Dev Salvi on 29/01/23.
//

import Foundation

func calTimeSince(date : Date)-> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60  // The interval between the date object and the current date and time
    // return value in miliseconds
    let hours = minutes/60
    let days = hours/24
    
    if minutes < 120 {
        return "\(minutes) Minutes ago"
    } else if minutes > 120 && hours < 48 {
        return "\(hours) Hours ago"
    }
    return "\(days) Days ago"
}
