//
//  Movie_API_AppApp.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//

import SwiftUI

@main
struct Movie_API_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(movieData: MovieData())
        }
    }
}
