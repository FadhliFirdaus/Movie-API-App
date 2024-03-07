//
//  MovieDataObservable.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 07/03/2024.
//

import Foundation
import CoreData

class MovieDataObservable: ObservableObject {
    let container = NSPersistentContainer(name: "MovieDataContainer")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
