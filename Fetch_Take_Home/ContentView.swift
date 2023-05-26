//
//  ContentView.swift
//  Fetch_Take_Home
//
//  Created by Jonathan Kearns on 5/23/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var viewModel = MealView()
    @State private var isSheetShowing = false
    @State private var searchTerm: String = ""
    @State private var selected: String?
    @State private var selectedId: String?
    
    var body: some View {
        // Nav view so list is scrollable
        NavigationView {
            VStack {
                // ----- Text field to search by id. Takes entered text into searchById func. ----
                TextField("Search By ID", text: $searchTerm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 10.0)
                    //.cornerRadius(15)
                    .onSubmit {
                        viewModel.searchById(id: searchTerm)
                        isSheetShowing = true
                     
                    }
                
                // List of all recipes in dessert category
                List(viewModel.meals, id: \.self) { meal in
                    // each list item is a button. Takes selectedId into the search by ID func to get the full details of the recipe. Shows a sheet view with all the details.
                    Button {
                        // get name and ID of meal to use in searchById func
                        selected = meal.strMeal
                        selectedId = meal.idMeal
                        viewModel.searchById(id: selectedId ?? "")
                        isSheetShowing = true
                       
                    } label: {
                        HStack {
                            // list item's label - a picture and the name of the recipe
                            if meal.strMealThumb == "" {
                                Image(systemName: "circle")
                            } else {
                                AsyncImage(url: URL(string: meal.strMealThumb), scale: 15)
                                    .cornerRadius(25)
                            }
                            Text(meal.strMeal)
                            
                        }
                        
                    }
                }
                .scrollContentBackground(.hidden)
                
                
                // --------------- SHEET VIEW ---------------
                // sheet is presented with the details of the recipe
                .sheet(isPresented: $isSheetShowing) {
                                    
                    if let fullMeal = viewModel.fullMeal {
                        
                        ScrollView{
                            VStack {
                                ZStack {
                                    // get's meal image
                                    AsyncImage(url: URL(string: fullMeal.strMealThumb), scale: 3) { image in
                                        image.resizable()
                                            .scaledToFit()
                                        
                                    } placeholder: {
                                        ProgressView()
                                }
                                    
                                // meal name/ID
                                    VStack {
                                        Text(fullMeal.strMeal ?? "")
                                            .font(.largeTitle)
                                            .multilineTextAlignment(.center)
                                            .textCase(.uppercase)
                                            .underline()
                                            .foregroundColor(.white)
                                            .dynamicTypeSize(.xxxLarge)
                                            .bold()
                                        
                                        Text("ID: " + (fullMeal.idMeal ?? ""))
                                            .font(.subheadline)
                                            .fontWeight(.light)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                            
                                // go through all 20 optional ingreditnes. If var not nil, will show indgredient and its' measurement.
                                ForEach(1...20, id: \.self) { index in
                                    if let ingredient = viewModel.getIngredient(at: index),
                                                       !ingredient.isEmpty,
                                                       let measurement = viewModel.getMeasurement(at: index),
                                                       !measurement.isEmpty {
                                                        Text(ingredient + " - " + measurement)
                                                }
                                            }
                                
                                // meal instructions
                                Text(fullMeal.strInstructions ?? "")
                                    .padding(15)
                            }
                            .presentationBackground(.ultraThinMaterial)
                        }
                    } else {
                        // if no result found by id:
                        Text("No Recipe Found")
                    }
                    
                }
                
            }
            // listview styling & when it appears, the dessertsPlease func runs.
            .listStyle(GroupedListStyle())
            .navigationTitle("Desserts")
            .onAppear{
                print("appeared!")
                viewModel.dessertPlease()
            }

            
        }
        .foregroundColor(.black)
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
