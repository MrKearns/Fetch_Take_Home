//
//  ViewModel.swift
//  Fetch_Take_Home
//
//  Created by Jonathan Kearns on 5/23/23.
//

import Foundation
import SwiftUI

final class MealView: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var fullMeal: FullMeal?
    @Published var selectedMeal: Meal?

// ---------- DESSERT PLEASE FUNC ----------
    // on appear of the listview, this func runs. It shows the results of the MealDB's dessert section using the given URL.
    func dessertPlease() {
       
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=dessert") else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                print("dessert please")
                
                DispatchQueue.main.async {
                    self.meals = response.meals
                    print("dessert please")
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
// --------------- BY ID FUNCTION ---------------
    // takes the id from tapping on listview item or as imput from textinput to search the MealDB for matching ID#. It uses the given URL + added ID# from input.
    func searchById(id: String) {
        fullMeal = nil
                
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {return}
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(FullResponse.self, from: data)
               
                DispatchQueue.main.async {
                    self.fullMeal = response.meals.first
                    //print(self.fullMeal)

                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    // --------------- GET INGREDIENTS FUNC ---------------
    // makes each possible ingreditne a case to check in ForEach loop in ContentView. Uses 1...20 as index paramater to step through the cases.
    func getIngredient(at index: Int) -> String? {
            switch index {
            case 1: return fullMeal?.strIngredient1
            case 2: return fullMeal?.strIngredient2
            case 3: return fullMeal?.strIngredient3
            case 4: return fullMeal?.strIngredient4
            case 5: return fullMeal?.strIngredient5
            case 6: return fullMeal?.strIngredient6
            case 7: return fullMeal?.strIngredient7
            case 8: return fullMeal?.strIngredient8
            case 9: return fullMeal?.strIngredient9
            case 10: return fullMeal?.strIngredient10
            case 11: return fullMeal?.strIngredient11
            case 12: return fullMeal?.strIngredient12
            case 13: return fullMeal?.strIngredient13
            case 14: return fullMeal?.strIngredient14
            case 15: return fullMeal?.strIngredient15
            case 16: return fullMeal?.strIngredient16
            case 17: return fullMeal?.strIngredient17
            case 18: return fullMeal?.strIngredient18
            case 19: return fullMeal?.strIngredient19
            case 20: return fullMeal?.strIngredient20
            default: return nil
            }
        }
    
    
    // --------------- GET MEASUREMENT FUNC ---------------
    // same as get ingredient func but for the measurements.
    func getMeasurement(at index: Int) -> String? {
            switch index {
            case 1: return fullMeal?.strMeasure1
            case 2: return fullMeal?.strMeasure2
            case 3: return fullMeal?.strMeasure3
            case 4: return fullMeal?.strMeasure4
            case 5: return fullMeal?.strMeasure5
            case 6: return fullMeal?.strMeasure6
            case 7: return fullMeal?.strMeasure7
            case 8: return fullMeal?.strMeasure8
            case 9: return fullMeal?.strMeasure9
            case 10: return fullMeal?.strMeasure10
            case 11: return fullMeal?.strMeasure11
            case 12: return fullMeal?.strMeasure12
            case 13: return fullMeal?.strMeasure13
            case 14: return fullMeal?.strMeasure14
            case 15: return fullMeal?.strMeasure15
            case 16: return fullMeal?.strMeasure16
            case 17: return fullMeal?.strMeasure17
            case 18: return fullMeal?.strMeasure18
            case 19: return fullMeal?.strMeasure19
            case 20: return fullMeal?.strMeasure20
            default: return nil
            }
        }
    
    
    
}

