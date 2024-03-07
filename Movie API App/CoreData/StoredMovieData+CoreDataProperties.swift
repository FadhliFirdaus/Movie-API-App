//
//  StoredMovieData+CoreDataProperties.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 07/03/2024.
//
//

import Foundation
import CoreData


extension StoredMovieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredMovieData> {
        return NSFetchRequest<StoredMovieData>(entityName: "StoredMovieData")
    }

    @NSManaged public var title: String?
    @NSManaged public var yearReleased: Int16

}

extension StoredMovieData : Identifiable {

}
