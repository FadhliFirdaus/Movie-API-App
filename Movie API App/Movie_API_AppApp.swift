//
//  Movie_API_AppApp.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import SwiftUI

@main
struct Movie_API_AppApp: App {
    @StateObject private var dataController = MovieDataObservable()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
