//
//  LaunchScreen.swift
//  Fetch_Take_Home
//
//  Created by Jonathan Kearns on 5/26/23.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive == true{
            ContentView()
        } else {
            ZStack {
                Color.black
                VStack {
                    Image(systemName: "birthday.cake.fill")
                        .foregroundColor(.white)
                    .font(.system(size: 50))
                    
                    Text("[dessert please]")
                        .foregroundColor(.white)
                        .background(.black)
                }
                
            }
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        isActive = true
                    }
                    
                }
            }
        }
    }
       
}
       

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
