    //
    //  Enums.swift
    //  Movie API App
    //
    //  Created by Fadhli Firdaus on 06/03/2024.
    //

import Foundation

enum Screens:String {
    case Main = "Main"
    case MovieDetailScreen = "MovieDetailScreen"
    case StoredMovieDetailScreen = "StoredMovieDetailScreen"
}

enum Tabs:String, CaseIterable, Identifiable {
    case Browse
    case Saved
    var id: String { return self.rawValue }
}
