//
//  Go_TaxiApp.swift
//  Go Taxi
//
//  Created by apple on 09.08.2023.
//

import SwiftUI

@main
struct Go_TaxiApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
