//
//  Meal.swift
//  Fetch_Take_Home
//
//  Created by Jonathan Kearns on 5/23/23.
//

import Foundation

// Meal struct used for inital onapper.
struct Meal: Codable, Hashable {
    // only properties included in category search
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

