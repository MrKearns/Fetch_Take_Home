//
//  Response.swift
//  Fetch_Take_Home
//
//  Created by Jonathan Kearns on 5/23/23.
//

import Foundation

// structs from the results of searching the MealDB5
struct Response: Codable {
    let meals: [Meal]
    
}

struct FullResponse: Codable {
    let meals: [FullMeal]
}
